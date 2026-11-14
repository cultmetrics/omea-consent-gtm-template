___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Omea Consent – Consent Mode",
  "categories": [
    "TAG_MANAGEMENT",
    "UTILITY"
  ],
  "brand": {
    "id": "github.com_cultmetrics",
    "displayName": "Cultmetrics",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAIAAABMXPacAAAABmJLR0QA/wD/AP+gvaeTAAAEr0lEQVR4nO3cz0syWxzH8ZnUsjZqmxbZH6DQPuKSf0GLqFlkpKVgGNmqX1DrbBPRqkgTtCJo06JF7QS5C6FNtHFdkJAU2Sbo18xdSNJ1Zrw+4JzPmbnf16rG4HzxjWfs5POIDodDIDgd6AH+7ygAGAUAowBgFACMAoBRADAKAEYBwCgAGAUAowBgFACMAoBRADAKAEYBwCgAGAUAowBgFACMAoBRADAKAEYBwCgAmJ3BGqFQaGhoiMFC7VUsFnO5nNGrsAgwMjISCoUYLNRenZ2dDALQFgRGAcAoABgFAGNxE1ZTFKVarUKW1uN2u0VRZL8uJsDr62tfXx9kaT2VSsXtdrNfl7YgMAoARgHAKAAYBQCjAGAUAIwCgFk/gM/ns9ls6Cl0WTyA1+vN5/NXV1f9/f3oWbRZOYDdbj8+Pu7t7Q0EAjc3NxMTE+iJNFg5wPr6+vDwcO1rl8t1cnKyu7vrdDqxUzWwbIBAILC2tvb7iiiK8Xg8k8mgRtJkzQAejyeTyajvve/v71tbW5CR9FgzQDqdHhgYUF9fWVm5vb1lP08TFgwQj8dHR0fV1y8uLvb399nP05zVAvj9fs1Nplwuz83NKYrCfqTmLBXA6XQeHR11d3c3XJdleXZ29unpCTJVc5YKsLOzMzg4qL6+ubmZz+fZz9MK6wQYGxuLRqPq69fX18lkkv08LbJIAK/Xu7e3p75erVaDweDn5yf7kVpkhQD1Iwf1QwsLC3d3d+xHap0VAmxsbNSPHH5LpVJnZ2fs5/kj/Aaw2WytHCMHAoHV1VX19VKptLy8bMBcbcZpAJvNdnh4mMvl7PZmHx1rcuQwPT399vZm5IztgflkXHO1Zz8YDNa+DYfDX19fmj9poiMHPdy9AhqefUmSstms5utgfn5e88jh8vKSwyMHPXwFaHj2azQb+P1+zXf35XI5Go1yeOSgh68AMzMzDc9+jSRJqVSqvtf39PScnp6qjxy+v79DoRCfRw56+AqQyWQODg40H5qamqrfk7e3t30+n/pnkslkoVAwdsR24+smrChKIpEQBCEWi6kflSRJEITz83MzHjno4SuAIAiKoiwuLnZ1dYXDYfWjkiSNj4+rr7+8vExOTvJ85KCHry2oRpblWCymtxd1dGjMnEgk7u/vDZ7LEDwGEH72Ir0GDdLpNP9HDno4DSC03KBUKi0tLbEZyQj8BhBaaGCiIwc9XAcQ/quBiY4c9PAeQNBvYK4jBz0mCCD8vDfNZrP1Kw8PD5FIxERHDnrMEUD493tTWZYjkcjz8zN6qDbg7hexJuq/J1cqFW4/5fCnzBRA+NmLIP+ngEFMFkAQBFmW0SO0k2nuAVZFAcAoABgFAMPchF0u1+PjI2RpPS6XC7IuJoAoih6PB7I0b2gLAqMAYBQAjAKAsbgJFwqFj48PBgu1V7FYZLCK6HA4GCxD9NAWBEYBwCgAGAUAowBgFACMAoBRADAKAEYBwCgAGAUAM/w09OVv8/27rd88fxl7WEmvADAKAEYBwCgAGP1FDIxeAWAUAIwCgFEAMAoARgHAKAAYBQCjAGAUAIwCgFEAMAoARgHAKAAYBQCjAGAUAIwCgFEAsH8APY9b66OuIOoAAAAASUVORK5CYII="
  },
  "description": "Google Consent Mode v2 for Omea Consent: denied defaults (per region), the visitor's stored choice and every later change, ads_data_redaction and url_passthrough. Fire on Consent Initialization – All Pages.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "intro",
    "displayName": "Sets Google Consent Mode v2 from <strong>Omea Consent</strong>: the default state before the visitor chooses, the stored choice of a returning visitor and every later change. Fire this tag on the <strong>Consent Initialization – All Pages</strong> trigger. On WordPress pages the Omea Consent plugin already sets all of this in the page head, before Google Tag Manager loads; this tag then does nothing (see Advanced)."
  },
  {
    "type": "GROUP",
    "name": "defaults",
    "displayName": "Default consent state",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "SELECT",
        "name": "defaultModel",
        "displayName": "Before the visitor chooses",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "opt_in",
            "displayValue": "Ask first – denied until the visitor chooses (opt-in)"
          },
          {
            "value": "opt_out",
            "displayValue": "Granted until the visitor opts out (opt-out, US states)"
          },
          {
            "value": "none",
            "displayValue": "No banner – granted"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "opt_in",
        "help": "Use the consent model set in Omea Consent. <strong>Ask first</strong>: analytics_storage, ad_storage, ad_user_data, ad_personalization, functionality_storage and personalization_storage are denied until the visitor chooses. <strong>Opt-out</strong> and <strong>No banner</strong>: granted, except the ad types when the browser sends Global Privacy Control. security_storage is always granted. Applies everywhere except the regions below."
      },
      {
        "type": "PARAM_TABLE",
        "name": "regionDefaults",
        "displayName": "Per region (optional)",
        "paramTableColumns": [
          {
            "param": {
              "type": "TEXT",
              "name": "region",
              "displayName": "Regions",
              "simpleValueType": true,
              "valueHint": "US-CA, US-CO",
              "valueValidators": [
                {
                  "type": "NON_EMPTY"
                }
              ]
            },
            "isUnique": true
          },
          {
            "param": {
              "type": "SELECT",
              "name": "model",
              "displayName": "Before the visitor chooses",
              "macrosInSelect": false,
              "selectItems": [
                {
                  "value": "opt_in",
                  "displayValue": "Ask first – denied until the visitor chooses (opt-in)"
                },
                {
                  "value": "opt_out",
                  "displayValue": "Granted until the visitor opts out (opt-out, US states)"
                },
                {
                  "value": "none",
                  "displayValue": "No banner – granted"
                }
              ],
              "simpleValueType": true,
              "defaultValue": "opt_out"
            },
            "isUnique": false
          }
        ],
        "help": "A different default for some regions, as in Omea Consent Pro's rules per region. Comma-separated <a href=\"https://en.wikipedia.org/wiki/ISO_3166-2\">ISO 3166-2</a> codes (country or region). Google applies the most specific row for the visitor."
      },
      {
        "type": "TEXT",
        "name": "waitForUpdate",
        "displayName": "Wait for update",
        "simpleValueType": true,
        "valueUnit": "milliseconds",
        "defaultValue": 500,
        "valueValidators": [
          {
            "type": "NON_NEGATIVE_NUMBER"
          }
        ],
        "help": "How long Google tags wait for the banner's update before they use the default. 500 is what Omea Consent uses; 0 leaves it out."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "googleSettings",
    "displayName": "Google settings",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "adsDataRedaction",
        "checkboxText": "Redact ads data while ad_storage is denied (ads_data_redaction)",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Google Ads and Floodlight tags drop ad click identifiers and use cookieless domains while ad_storage is denied. Omea Consent always sets this."
      },
      {
        "type": "CHECKBOX",
        "name": "urlPassthrough",
        "checkboxText": "Pass ad click information in links while ad_storage is denied (url_passthrough)",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Ad click IDs (gclid, dclid, wbraid …) travel in internal links instead of cookies. Same as the Omea Consent setting; off by default."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "advanced",
    "displayName": "Advanced",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "skipWhenOmeaHead",
        "checkboxText": "Leave Consent Mode to the Omea Consent plugin when its own code is on the page",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "The Omea Consent WordPress plugin (1.0.9 and later) sets the defaults in the page head before Google Tag Manager loads and sends every update itself. Setting them again here would only duplicate them, so the tag does nothing on those pages. Untick only if you have a reason to set the defaults twice."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Omea Consent – Google Consent Mode v2 for Google Tag Manager.
// Fire on "Consent Initialization – All Pages". Mirrors what the Omea Consent
// plugin prints in <head> on WordPress pages, for pages where GTM sets it instead.
const callInWindow = require('callInWindow');
const copyFromWindow = require('copyFromWindow');
const getCookieValues = require('getCookieValues');
const getType = require('getType');
const gtagSet = require('gtagSet');
const JSON = require('JSON');
const logToConsole = require('logToConsole');
const makeNumber = require('makeNumber');
const makeString = require('makeString');
const setDefaultConsentState = require('setDefaultConsentState');
const setInWindow = require('setInWindow');
const updateConsentState = require('updateConsentState');

// Omea's Google CMP developer ID, assigned by Google's CMP Partner Program 2026-11-14
// (same value as OMEA_CONSENT_GOOGLE_DEVELOPER_ID in the plugin).
const OMEA_DEVELOPER_ID = 'dZTMwN2';
const COOKIE_NAME = 'omea_consent_state';
const ID_CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-';

// Omea category → Google consent types, as in the plugin. Necessary → security_storage (always granted).
const SIGNALS = {
  statistics: ['analytics_storage'],
  functional: ['functionality_storage', 'personalization_storage'],
  marketing: ['ad_storage', 'ad_user_data', 'ad_personalization']
};
const CATEGORIES = ['statistics', 'functional', 'marketing'];

const log = (message) => {
  logToConsole('Omea Consent template: ' + message);
};

// Letters, digits, '_' and '-' only; anything else gives no ID.
const cleanId = (value) => {
  const id = makeString(value || '').trim();
  const bad = id.split('').filter((c) => ID_CHARS.indexOf(c) < 0);
  return bad.length === 0 ? id : '';
};

// Default state for one consent model, as the plugin builds it:
// opt_in = denied until the visitor chooses; opt_out / none = granted, except the
// ad types when the browser sends Global Privacy Control.
const stateFor = (model, gpc) => {
  const granted = model === 'opt_out' || model === 'none';
  const state = {};
  CATEGORIES.forEach((category) => {
    SIGNALS[category].forEach((type) => {
      state[type] = granted && !(gpc && category === 'marketing') ? 'granted' : 'denied';
    });
  });
  state.security_storage = 'granted';
  return state;
};

// The visitor's stored choice from Omea's cookie, or null when there is none (or it is unreadable).
const readChoice = () => {
  const values = getCookieValues(COOKIE_NAME);
  if (!values || values.length === 0) {
    return null;
  }
  const choice = JSON.parse(values[0]);
  return getType(choice) === 'object' ? choice : null;
};

const choiceState = (choice) => {
  const state = {};
  CATEGORIES.forEach((category) => {
    SIGNALS[category].forEach((type) => {
      state[type] = choice && choice[category] === true ? 'granted' : 'denied';
    });
  });
  return state;
};

// The last state applied from the cookie on this page ('' = none yet). The banner
// announces the same choice again when it starts: that sends nothing new.
let applied = '';
const apply = (choice) => {
  const state = choiceState(choice);
  const key = JSON.stringify(state);
  if (key === applied) {
    return;
  }
  applied = key;
  updateConsentState(state);
};

// Omea fires `cmp:consent` when the banner starts and on every choice, after it has
// written the cookie. A record flagged _d is an opt-out region's default, not a choice:
// the defaults cover it. No record after a choice was applied means it was withdrawn or
// expired: everything optional is denied. No record before that: the defaults still hold.
const onConsent = () => {
  const choice = readChoice();
  if (choice && !choice._d) {
    apply(choice);
  } else if (!choice && applied !== '') {
    apply(null);
  }
};

const main = () => {
  const developerId = cleanId(OMEA_DEVELOPER_ID);
  if (developerId !== '') {
    gtagSet('developer_id.' + developerId, true);
  }

  // On WordPress the plugin already set the defaults in <head>, before GTM, and sends the
  // updates itself: setting them again here would only duplicate them.
  if (data.skipWhenOmeaHead !== false && copyFromWindow('omeaConsentModeDefaults')) {
    log('Omea Consent already set Consent Mode on this page; nothing to do.');
    return;
  }
  // Tells Omea's own code (the embed line added later through GTM) that the defaults are set.
  setInWindow('omeaConsentGtmTemplate', true, true);

  gtagSet('ads_data_redaction', data.adsDataRedaction !== false);
  if (data.urlPassthrough === true) {
    gtagSet('url_passthrough', true);
  }

  const gpc = copyFromWindow('navigator.globalPrivacyControl') === true;
  const wait = makeNumber(data.waitForUpdate);
  const rows = getType(data.regionDefaults) === 'array' ? data.regionDefaults : [];
  rows.forEach((row) => {
    const regions = makeString(row.region || '').split(',')
      .map((code) => code.trim().toUpperCase())
      .filter((code) => code.length > 0);
    if (regions.length === 0) {
      return;
    }
    const state = stateFor(row.model, gpc);
    state.region = regions;
    if (wait > 0) {
      state.wait_for_update = wait;
    }
    setDefaultConsentState(state);
  });
  const state = stateFor(data.defaultModel, gpc);
  if (wait > 0) {
    state.wait_for_update = wait;
  }
  setDefaultConsentState(state);

  // A returning visitor: the stored choice right away.
  const choice = readChoice();
  if (choice && !choice._d) {
    apply(choice);
  }
  callInWindow('addEventListener', 'cmp:consent', onConsent);
};

main();
data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "omeaConsentModeDefaults"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "omeaConsentGtmTemplate"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "navigator.globalPrivacyControl"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "addEventListener"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "omea_consent_state"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "write_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "ads_data_redaction"
              },
              {
                "type": 1,
                "string": "url_passthrough"
              },
              {
                "type": 1,
                "string": "developer_id.dZTMwN2"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Defaults – everything optional denied, wait_for_update, ads_data_redaction, listener
  code: |-
    runCode(mockData);
    assertApi('setDefaultConsentState').wasCalledWith(withWait(ALL_DENIED, 500));
    assertApi('gtagSet').wasCalledWith('ads_data_redaction', true);
    assertApi('gtagSet').wasNotCalledWith('url_passthrough', true);
    assertApi('updateConsentState').wasNotCalled();
    assertApi('callInWindow').wasCalled();
    assertApi('gtmOnSuccess').wasCalled();
- name: Developer ID – Omea's ID is sent first, before the defaults
  code: |-
    const order = [];
    mock('gtagSet', (key, value) => { order.push(key + '=' + value); });
    mock('setDefaultConsentState', () => { order.push('default'); });
    runCode(mockData);
    assertThat(order[0]).isEqualTo('developer_id.dZTMwN2=true');
    assertThat(order.indexOf('default') > 0).isTrue();
    assertThat(order.filter((k) => k.indexOf('developer_id') === 0)).hasLength(1);
- name: Region rows – own default per region, then the global one
  code: |-
    let calls = 0;
    mock('setDefaultConsentState', () => { calls = calls + 1; });
    mockData.regionDefaults = [
      {region: 'us-ca, US-CO', model: 'opt_out'},
      {region: ' , ', model: 'opt_out'}
    ];
    runCode(mockData);
    assertThat(calls).isEqualTo(2);
- name: Region rows – values
  code: |-
    mockData.regionDefaults = [{region: 'us-ca, US-CO', model: 'opt_out'}];
    runCode(mockData);
    const usState = withWait(ALL_GRANTED, 500);
    usState.region = ['US-CA', 'US-CO'];
    assertApi('setDefaultConsentState').wasCalledWith(usState);
    assertApi('setDefaultConsentState').wasCalledWith(withWait(ALL_DENIED, 500));
- name: Global Privacy Control keeps the ad types denied where defaults are granted
  code: |-
    windowValues['navigator.globalPrivacyControl'] = true;
    mockData.defaultModel = 'opt_out';
    runCode(mockData);
    const expected = withWait(ALL_GRANTED, 500);
    expected.ad_storage = 'denied';
    expected.ad_user_data = 'denied';
    expected.ad_personalization = 'denied';
    assertApi('setDefaultConsentState').wasCalledWith(expected);
- name: No banner (none) model – granted
  code: |-
    mockData.defaultModel = 'none';
    mockData.waitForUpdate = 0;
    runCode(mockData);
    assertApi('setDefaultConsentState').wasCalledWith(ALL_GRANTED);
- name: Returning visitor – the stored choice is applied at once
  code: |-
    cookieValue = JSON.stringify({necessary: true, statistics: true, functional: false, marketing: true, _t: 1762560000000, _v: 'abc'});
    runCode(mockData);
    assertApi('updateConsentState').wasCalledWith({
      analytics_storage: 'granted',
      functionality_storage: 'denied',
      personalization_storage: 'denied',
      ad_storage: 'granted',
      ad_user_data: 'granted',
      ad_personalization: 'granted'
    });
- name: The same choice announced again sends no second update
  code: |-
    let listener;
    let updates = 0;
    mock('callInWindow', (path, type, fn) => { listener = fn; });
    mock('updateConsentState', () => { updates = updates + 1; });
    cookieValue = JSON.stringify({necessary: true, statistics: true, functional: true, marketing: true, _t: 1762560000000});
    runCode(mockData);
    listener();
    assertThat(updates).isEqualTo(1);
- name: An opt-out region's default record (_d) is not a choice
  code: |-
    cookieValue = JSON.stringify({necessary: true, statistics: true, functional: true, marketing: true, _d: 1});
    runCode(mockData);
    assertApi('updateConsentState').wasNotCalled();
- name: An unreadable cookie is ignored
  code: |-
    cookieValue = '{not json';
    runCode(mockData);
    assertApi('updateConsentState').wasNotCalled();
    assertApi('gtmOnSuccess').wasCalled();
- name: A new choice (cmp:consent) is applied; a withdrawn one denies everything
  code: |-
    let listener;
    mock('callInWindow', (path, type, fn) => {
      if (path === 'addEventListener' && type === 'cmp:consent') {
        listener = fn;
      }
    });
    runCode(mockData);
    assertThat(listener).isDefined();
    cookieValue = JSON.stringify({necessary: true, statistics: false, functional: true, marketing: false, _t: 1762560000000});
    listener();
    assertApi('updateConsentState').wasCalledWith({
      analytics_storage: 'denied',
      functionality_storage: 'granted',
      personalization_storage: 'granted',
      ad_storage: 'denied',
      ad_user_data: 'denied',
      ad_personalization: 'denied'
    });
    cookieValue = undefined;
    listener();
    assertApi('updateConsentState').wasCalledWith(NO_CHOICE);
- name: A cmp:consent without any choice yet (the banner starting) changes nothing
  code: |-
    let listener;
    mock('callInWindow', (path, type, fn) => { listener = fn; });
    runCode(mockData);
    listener();
    assertApi('updateConsentState').wasNotCalled();
- name: A cmp:consent with an opt-out default record (_d) changes nothing
  code: |-
    let listener;
    mock('callInWindow', (path, type, fn) => { listener = fn; });
    runCode(mockData);
    cookieValue = JSON.stringify({necessary: true, statistics: true, functional: true, marketing: true, _d: 1});
    listener();
    assertApi('updateConsentState').wasNotCalled();
- name: Omea's own head code on the page – the template leaves Consent Mode to it
  code: |-
    windowValues.omeaConsentModeDefaults = 1;
    runCode(mockData);
    assertApi('setDefaultConsentState').wasNotCalled();
    assertApi('updateConsentState').wasNotCalled();
    assertApi('callInWindow').wasNotCalled();
    assertApi('setInWindow').wasNotCalled();
    assertApi('gtmOnSuccess').wasCalled();
- name: Omea's head code on the page, skipping switched off – defaults set anyway
  code: |-
    windowValues.omeaConsentModeDefaults = 1;
    mockData.skipWhenOmeaHead = false;
    runCode(mockData);
    assertApi('setDefaultConsentState').wasCalledWith(withWait(ALL_DENIED, 500));
- name: Marks the page so Omea's embed line doesn't set the defaults again
  code: |-
    runCode(mockData);
    assertApi('setInWindow').wasCalledWith('omeaConsentGtmTemplate', true, true);
- name: url_passthrough when switched on; ads_data_redaction off when unticked
  code: |-
    mockData.urlPassthrough = true;
    mockData.adsDataRedaction = false;
    runCode(mockData);
    assertApi('gtagSet').wasCalledWith('url_passthrough', true);
    assertApi('gtagSet').wasCalledWith('ads_data_redaction', false);
setup: |-
  const JSON = require('JSON');
  const mockData = {
    defaultModel: 'opt_in',
    regionDefaults: [],
    waitForUpdate: '500',
    adsDataRedaction: true,
    urlPassthrough: false,
    skipWhenOmeaHead: true
  };
  const windowValues = {};
  mock('copyFromWindow', (key) => windowValues[key]);
  let cookieValue;
  mock('getCookieValues', (name) => (name === 'omea_consent_state' && cookieValue !== undefined) ? [cookieValue] : []);
  const ALL_DENIED = {
    ad_storage: 'denied',
    ad_user_data: 'denied',
    ad_personalization: 'denied',
    analytics_storage: 'denied',
    functionality_storage: 'denied',
    personalization_storage: 'denied',
    security_storage: 'granted'
  };
  const ALL_GRANTED = {
    ad_storage: 'granted',
    ad_user_data: 'granted',
    ad_personalization: 'granted',
    analytics_storage: 'granted',
    functionality_storage: 'granted',
    personalization_storage: 'granted',
    security_storage: 'granted'
  };
  const NO_CHOICE = {
    ad_storage: 'denied',
    ad_user_data: 'denied',
    ad_personalization: 'denied',
    analytics_storage: 'denied',
    functionality_storage: 'denied',
    personalization_storage: 'denied'
  };
  const KEYS = ['ad_storage', 'ad_user_data', 'ad_personalization', 'analytics_storage', 'functionality_storage', 'personalization_storage', 'security_storage'];
  const withWait = (state, ms) => {
    const out = {};
    KEYS.forEach((key) => {
      out[key] = state[key];
    });
    out.wait_for_update = ms;
    return out;
  };


___NOTES___

Omea Consent (https://wordpress.org/plugins/omea-consent/) by Cultmetrics.
