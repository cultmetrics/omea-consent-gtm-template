#!/usr/bin/env node
/*
 * Runs the template's own tests (the ___TESTS___ section of template.tpl, the same
 * scenarios GTM's template editor runs) outside Google Tag Manager, plus static checks
 * of the template and the gallery repository layout.
 *
 *   node omea-consent/gtm-template/tests/run-tests.js
 *
 * Exit code 0 = all passed. Used by omea-qa (tests/consent/gtm-template.spec.js).
 */
'use strict';
const fs = require('fs');
const path = require('path');
const { parseTemplate, readPermissions, lintSandboxCode, createRuntime } = require('./sandbox');

const ROOT = path.join(__dirname, '..');

// The block-style YAML GTM writes for ___TESTS___: scenarios (name, code: |-) and setup: |-.
function parseTests(yaml) {
  const lines = yaml.split('\n');
  const scenarios = [];
  let setup = '';
  let block = null; // { indent, lines, done(text) }
  const flush = () => { if (block) { block.done(block.lines.join('\n').replace(/\s+$/, '')); block = null; } };
  for (const line of lines) {
    if (block) {
      const indent = line.match(/^ */)[0].length;
      if (line.trim() === '' || indent >= block.indent) { block.lines.push(line.slice(block.indent)); continue; }
      flush();
    }
    let m;
    if ((m = line.match(/^- name: (.*)$/))) { scenarios.push({ name: m[1].trim().replace(/^(['"])(.*)\1$/, '$2'), code: '' }); continue; }
    if (/^  code: \|-?\s*$/.test(line)) { const s = scenarios[scenarios.length - 1]; block = { indent: 4, lines: [], done: (t) => { s.code = t; } }; continue; }
    if (/^setup: \|-?\s*$/.test(line)) { block = { indent: 2, lines: [], done: (t) => { setup = t; } }; continue; }
    if (/^scenarios:/.test(line) || line.trim() === '') continue;
    throw new Error('Unsupported ___TESTS___ line (use block style "code: |-"): ' + line);
  }
  flush();
  return { scenarios, setup };
}

const isObj = (v) => v !== null && typeof v === 'object';
function deepEqual(a, b) {
  if (a === b) return true;
  if (Array.isArray(a) !== Array.isArray(b) || !isObj(a) || !isObj(b)) return false;
  const ka = Object.keys(a).filter((k) => a[k] !== undefined);
  const kb = Object.keys(b).filter((k) => b[k] !== undefined);
  return ka.length === kb.length && ka.every((k) => deepEqual(a[k], b[k]));
}
const show = (v) => { try { return JSON.stringify(v); } catch (e) { return String(v); } };

class AssertionError extends Error {}

function runScenario(sandboxCode, perms, setup, scenario) {
  const calls = [];
  const listeners = [];
  const fakeWindow = {
    navigator: {},
    dataLayer: [],
    addEventListener: (type, fn) => { listeners.push({ type, fn }); },
  };
  const rt = createRuntime({
    perms,
    window: fakeWindow,
    cookie: () => '',
    onCall: (name, args) => calls.push({ name, args }),
  });
  const fail = (msg) => { throw new AssertionError(msg); };
  const assertApi = (name) => {
    const of = () => calls.filter((c) => c.name === name);
    const withArgs = (expected) => of().some((c) => deepEqual(c.args.slice(0, expected.length), expected) && c.args.length >= expected.length);
    return {
      wasCalled: () => { if (!of().length) fail(`${name} was not called`); },
      wasNotCalled: () => { if (of().length) fail(`${name} was called: ${show(of().map((c) => c.args))}`); },
      wasCalledWith: (...expected) => { if (!withArgs(expected)) fail(`${name} was not called with ${show(expected)}; calls: ${show(of().map((c) => c.args))}`); },
      wasNotCalledWith: (...expected) => { if (withArgs(expected)) fail(`${name} was called with ${show(expected)}`); },
    };
  };
  const assertThat = (actual, message) => {
    const m = (cond, what) => { if (!cond) fail((message ? message + ': ' : '') + `expected ${show(actual)} ${what}`); };
    return {
      isEqualTo: (e) => m(deepEqual(actual, e), `to equal ${show(e)}`),
      isNotEqualTo: (e) => m(!deepEqual(actual, e), `not to equal ${show(e)}`),
      isStrictlyEqualTo: (e) => m(actual === e, `to be ${show(e)}`),
      isTrue: () => m(actual === true, 'to be true'),
      isFalse: () => m(actual === false, 'to be false'),
      isUndefined: () => m(actual === undefined, 'to be undefined'),
      isDefined: () => m(actual !== undefined, 'to be defined'),
      isNull: () => m(actual === null, 'to be null'),
      isNotNull: () => m(actual !== null, 'not to be null'),
      isEmpty: () => m(actual && actual.length === 0, 'to be empty'),
      isNotEmpty: () => m(actual && actual.length > 0, 'not to be empty'),
      hasLength: (n) => m(actual && actual.length === n, `to have length ${n}`),
      contains: (...xs) => m(Array.isArray(actual) ? xs.every((x) => actual.some((y) => deepEqual(x, y))) : xs.every((x) => String(actual).indexOf(x) >= 0), `to contain ${show(xs)}`),
    };
  };
  const runCode = (data) => rt.run(sandboxCode, data);
  // Setup and scenario share one scope, as in GTM.
  // eslint-disable-next-line no-new-func
  new Function('mock', 'assertApi', 'assertThat', 'runCode', 'fail', 'require', setup + '\n;\n' + scenario.code)(
    rt.mock, assertApi, assertThat, runCode, fail, rt.require,
  );
}

function runAll(templatePath = path.join(ROOT, 'template.tpl')) {
  const results = [];
  const check = (name, fn) => {
    try { fn(); results.push({ name, ok: true }); } catch (e) { results.push({ name, ok: false, error: e.message }); }
  };
  const tpl = parseTemplate(fs.readFileSync(templatePath, 'utf8'));
  const code = tpl.___SANDBOXED_JS_FOR_WEB_TEMPLATE___ || '';
  let perms = null;

  check('static: every section present', () => {
    const need = ['___TERMS_OF_SERVICE___', '___INFO___', '___TEMPLATE_PARAMETERS___', '___SANDBOXED_JS_FOR_WEB_TEMPLATE___', '___WEB_PERMISSIONS___', '___TESTS___'];
    const missing = need.filter((s) => !(s in tpl));
    if (missing.length) throw new Error('missing ' + missing.join(', '));
  });
  check('static: ___INFO___ is a web tag with brand, categories and description', () => {
    const info = JSON.parse(tpl.___INFO___);
    if (info.type !== 'TAG' || !(info.containerContexts || []).includes('WEB')) throw new Error('not a WEB tag');
    if (!info.brand || !info.brand.id || !/^data:image\/png;base64,/.test(info.brand.thumbnail || '')) throw new Error('brand / thumbnail missing');
    if (!Array.isArray(info.categories) || !info.categories.length || info.categories.length > 3) throw new Error('1–3 categories');
    if (!info.displayName || !info.description) throw new Error('displayName / description');
    // GTM's Template Editor: the description holds at most 200 characters.
    if ([...info.description].length > 200) throw new Error('description over 200 characters (' + [...info.description].length + ')');
  });
  // GTM's Template Editor rejects a test name with ':' ("The name contains invalid character").
  check('static: test names have no characters GTM rejects', () => {
    const bad = (tpl.___TESTS___ || '').split('\n').filter((l) => /^- name: /.test(l) && l.slice(8).includes(':'));
    if (bad.length) throw new Error('":" in ' + bad.map((l) => l.slice(8)).join(' | '));
  });
  check('static: every data.<field> the code reads is a template parameter', () => {
    const names = new Set();
    const walk = (ps) => (ps || []).forEach((p) => { if (p.name) names.add(p.name); walk(p.subParams); });
    walk(JSON.parse(tpl.___TEMPLATE_PARAMETERS___));
    const used = [...new Set((code.match(/\bdata\.([A-Za-z_]+)/g) || []).map((s) => s.slice(5)))].filter((n) => !/^gtmOn/.test(n));
    const unknown = used.filter((n) => !names.has(n));
    if (unknown.length) throw new Error('not parameters: ' + unknown.join(', '));
  });
  check('static: permissions parse', () => { perms = readPermissions(tpl.___WEB_PERMISSIONS___); });
  check('static: sandboxed JS uses only supported syntax', () => {
    const bad = lintSandboxCode(code);
    if (bad.length) throw new Error('unsupported: ' + bad.join(', '));
  });
  check('static: gallery files (LICENSE = Apache 2.0, metadata.yaml)', () => {
    const lic = fs.readFileSync(path.join(path.dirname(templatePath), 'LICENSE'), 'utf8');
    if (!/Apache License\s+Version 2\.0/.test(lic)) throw new Error('LICENSE is not Apache 2.0');
    const meta = fs.readFileSync(path.join(path.dirname(templatePath), 'metadata.yaml'), 'utf8');
    if (!/^homepage: "https:\/\//m.test(meta) || !/^documentation: "https:\/\//m.test(meta) || !/^versions:/m.test(meta)) throw new Error('metadata.yaml fields');
  });

  if (perms) {
    const { scenarios, setup } = parseTests(tpl.___TESTS___ || '');
    if (!scenarios.length) results.push({ name: 'tests: at least one scenario', ok: false, error: 'none' });
    scenarios.forEach((s) => check('test: ' + s.name, () => runScenario(code, perms, setup, s)));
  }
  return results;
}

module.exports = { runAll, parseTests };

if (require.main === module) {
  const results = runAll(process.argv[2]);
  results.forEach((r) => console.log(`${r.ok ? 'ok  ' : 'FAIL'} ${r.name}${r.ok ? '' : '\n     ' + r.error}`));
  const failed = results.filter((r) => !r.ok).length;
  console.log(`\n${results.length - failed}/${results.length} passed`);
  process.exit(failed ? 1 : 0);
}
