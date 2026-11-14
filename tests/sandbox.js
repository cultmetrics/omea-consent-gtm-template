/*
 * A small stand-in for Google Tag Manager's sandboxed-JS runtime, so the template can be
 * tested outside GTM: in Node (run-tests.js, the template's own ___TESTS___) and in a real
 * browser page (omea-qa consent/gtm-template, against the real Omea banner).
 *
 * Every API checks the permissions declared in the template's ___WEB_PERMISSIONS___ –
 * stricter than GTM's test runner, which skips permission checks for mocked APIs.
 *
 * Not GTM itself: the template must also pass GTM's own test runner before a release
 * (README.md, "Before submitting").
 */
(function (root) {
  'use strict';

  // Sections of a .tpl file: { '___INFO___': '…', … }.
  function parseTemplate(text) {
    const out = {};
    const re = /^(___[A-Z_]+___)\s*$/gm;
    const marks = [];
    let m;
    while ((m = re.exec(text))) marks.push({ name: m[1], start: m.index, end: re.lastIndex });
    marks.forEach((mark, i) => {
      out[mark.name] = text.slice(mark.end, i + 1 < marks.length ? marks[i + 1].start : text.length).trim();
    });
    return out;
  }

  // ___WEB_PERMISSIONS___ JSON → { globals: {key: {read, write, execute}}, cookies: [], dataLayer: [], consent: {type: {read, write}}, logging }
  function readPermissions(json) {
    const perms = { globals: {}, cookies: null, dataLayer: [], consent: {}, logging: null };
    const val = (v) => (v.type === 1 ? v.string : v.type === 8 ? v.boolean : v.type === 2 ? (v.listItem || []).map(val) : v.type === 3 ? v.mapKey.reduce((o, k, i) => { o[val(k)] = val(v.mapValue[i]); return o; }, {}) : undefined);
    JSON.parse(json).forEach((p) => {
      const id = p.instance.key.publicId;
      const param = {};
      (p.instance.param || []).forEach((x) => { param[x.key] = val(x.value); });
      if (id === 'access_globals') (param.keys || []).forEach((k) => { perms.globals[k.key] = k; });
      if (id === 'get_cookies') perms.cookies = param.cookieAccess === 'any' ? '*' : (param.cookieNames || []);
      if (id === 'write_data_layer') perms.dataLayer = param.keyPatterns || [];
      if (id === 'access_consent') (param.consentTypes || []).forEach((c) => { perms.consent[c.consentType] = c; });
      if (id === 'logging') perms.logging = param.environments;
    });
    return perms;
  }

  // Constructs GTM's sandboxed JS does not support. A cheap guard, not a parser.
  function lintSandboxCode(code) {
    const stripped = code.replace(/\/\/[^\n]*/g, '').replace(/'(?:\\.|[^'\\\n])*'/g, "''");
    const rules = [
      [/\btypeof\b/, 'typeof (use getType)'],
      [/\bnew\s+[A-Z]/, 'new'],
      [/\bthis\b/, 'this'],
      [/\bclass\s+[A-Za-z]/, 'class'],
      [/`/, 'template literals'],
      [/\btry\s*\{/, 'try/catch'],
      [/\bfor\s*\([^;)]*\b(in|of)\b/, 'for…in / for…of'],
      [/\bwindow\b|\bdocument\b/, 'window/document (use the APIs)'],
      [/\.\.\.[A-Za-z_]/, 'spread'],
      [/\?\.|\?\?/, 'optional chaining / nullish coalescing'],
    ];
    return rules.filter(([re]) => re.test(stripped)).map(([, what]) => what);
  }

  class PermissionError extends Error {}

  /**
   * env: { perms, window, cookie(): string, onCall(name, args) }
   * Returns require(name) honouring mocks (looked up at call time).
   */
  function createRuntime(env) {
    const perms = env.perms;
    const mocks = {};
    const deny = (msg) => { throw new PermissionError('Permission denied: ' + msg); };
    const globalOk = (key, what) => {
      const g = perms.globals[key];
      if (!g || !g[what]) deny(`${what} access to window.${key} is not declared`);
    };
    const dlOk = (key) => {
      const ok = perms.dataLayer.some((p) => (p.endsWith('*') ? key.indexOf(p.slice(0, -1)) === 0 : key === p));
      if (!ok) deny(`write_data_layer key ${key}`);
    };
    const consentOk = (state) => {
      Object.keys(state).forEach((k) => {
        if (k === 'region' || k === 'wait_for_update') return;
        if (!perms.consent[k] || !perms.consent[k].write) deny(`write access to consent type ${k}`);
      });
    };
    const path = (key) => key.split('.');
    const lookup = (key) => path(key).reduce((o, k) => (o === undefined || o === null ? undefined : o[k]), env.window);
    const copy = (v) => (v === undefined || typeof v === 'function' ? v : JSON.parse(JSON.stringify(v)));
    const gtag = function () { (env.window.dataLayer = env.window.dataLayer || []).push(arguments); };
    const getType = (v) => (v === null ? 'null' : Array.isArray(v) ? 'array' : typeof v);

    // Permission checks run for mocked APIs too (GTM's test runner skips them).
    const guards = {
      callInWindow: (key) => globalOk(key, 'execute'),
      copyFromWindow: (key) => globalOk(key, 'read'),
      setInWindow: (key) => globalOk(key, 'write'),
      getCookieValues: (name) => { if (perms.cookies !== '*' && (!perms.cookies || perms.cookies.indexOf(name) < 0)) deny(`get_cookies ${name}`); },
      gtagSet: (key) => { if (key && typeof key === 'object') Object.keys(key).forEach(dlOk); else dlOk(String(key)); },
      setDefaultConsentState: (state) => consentOk(state || {}),
      updateConsentState: (state) => consentOk(state || {}),
      logToConsole: () => { if (!perms.logging) deny('logging'); },
    };

    const apis = {
      callInWindow(key, ...args) {
        const parts = path(key);
        const owner = parts.length > 1 ? lookup(parts.slice(0, -1).join('.')) : env.window;
        const fn = owner && owner[parts[parts.length - 1]];
        return typeof fn === 'function' ? fn.apply(owner, args) : undefined;
      },
      copyFromWindow(key) { return copy(lookup(key)); },
      setInWindow(key, value, override) {
        const parts = path(key);
        const owner = parts.length > 1 ? lookup(parts.slice(0, -1).join('.')) : env.window;
        const last = parts[parts.length - 1];
        if (!owner || (owner[last] !== undefined && !override)) return false;
        owner[last] = value;
        return true;
      },
      getCookieValues(name, decode) {
        return String(env.cookie() || '').split(/;\s*/).filter(Boolean).map((c) => {
          const i = c.indexOf('=');
          return i > 0 && c.slice(0, i) === name ? c.slice(i + 1) : null;
        }).filter((v) => v !== null).map((v) => {
          if (decode === false) return v;
          try { return decodeURIComponent(v); } catch (e) { return undefined; }
        }).filter((v) => v !== undefined);
      },
      gtagSet(key, value) {
        if (key && typeof key === 'object') {
          gtag('set', key);
        } else {
          gtag('set', key, value);
        }
      },
      setDefaultConsentState(state) { gtag('consent', 'default', copy(state)); },
      updateConsentState(state) { gtag('consent', 'update', copy(state)); },
      logToConsole(...args) { if (env.log) env.log(...args); },
      getType,
      makeNumber: (v) => Number(v),
      makeString: (v) => String(v),
      makeInteger: (v) => Math.trunc(Number(v)),
      decodeUriComponent(v) { try { return decodeURIComponent(v); } catch (e) { return undefined; } },
      JSON: {
        parse(s) { try { return JSON.parse(String(s)); } catch (e) { return undefined; } },
        stringify(v) { try { return JSON.stringify(v); } catch (e) { return undefined; } },
      },
    };

    const required = {};
    function require(name) {
      if (!(name in apis)) throw new Error('Unknown sandbox API: ' + name);
      if (name === 'JSON') return apis.JSON;
      if (!required[name]) {
        required[name] = function (...args) {
          if (guards[name]) guards[name](...args);
          if (env.onCall) env.onCall(name, args);
          return name in mocks ? (typeof mocks[name] === 'function' ? mocks[name](...args) : mocks[name]) : apis[name](...args);
        };
      }
      return required[name];
    }
    function mock(name, impl) { mocks[name] = impl; }
    function reset() { Object.keys(mocks).forEach((k) => { delete mocks[k]; }); }

    // Runs the template body with `data` (gtmOnSuccess / gtmOnFailure added).
    function run(code, data) {
      const d = Object.assign({}, data);
      d.gtmOnSuccess = () => { if (env.onCall) env.onCall('gtmOnSuccess', []); };
      d.gtmOnFailure = () => { if (env.onCall) env.onCall('gtmOnFailure', []); };
      // eslint-disable-next-line no-new-func
      return new Function('require', 'data', code)(require, d);
    }

    return { require, mock, reset, run, apis };
  }

  const api = { parseTemplate, readPermissions, lintSandboxCode, createRuntime, PermissionError };
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
  else root.OmeaGtmSandbox = api;
})(typeof globalThis !== 'undefined' ? globalThis : this);
