# Omea Consent – Consent Mode template for Google Tag Manager

A Google Tag Manager tag template (sandboxed JavaScript) that sets Google Consent Mode v2
from [Omea Consent](https://wordpress.org/plugins/omea-consent/), the consent banner for
WordPress by [Cultmetrics](https://cultmetrics.com/). Documentation:
[Google Tag Manager consent mode on WordPress](https://www.cultmetrics.com/support/omea-consent/gtm-consent-mode-wordpress/).

## What the tag does

Fire it on **Consent Initialization – All Pages**.

1. **Developer ID** – `gtagSet('developer_id.dZTMwN2', true)` first, before the defaults:
   Omea Consent's Google developer ID (`OMEA_DEVELOPER_ID` in the code; the
   `write_data_layer` permission allows only this key).
2. **Leaves WordPress pages to the plugin.** The Omea Consent plugin (1.0.9+) prints the same
   defaults in `<head>` before GTM loads, sends every update itself and sets
   `window.omeaConsentModeDefaults`. When that flag is there the tag does nothing else, so the
   defaults are never set twice (*Advanced › Leave Consent Mode to the Omea Consent plugin*,
   on by default).
3. **Marks the page** (`window.omeaConsentGtmTemplate`), so Omea's own code that arrives
   later (the embed line added through GTM) skips its defaults.
4. `ads_data_redaction` (on by default, as in the plugin) and `url_passthrough` (off by
   default, as in the plugin).
5. **Defaults** with `setDefaultConsentState`, mapped exactly as the plugin maps them:

   | Omea category | Google consent types |
   |---|---|
   | Statistics | `analytics_storage` |
   | Functional | `functionality_storage`, `personalization_storage` |
   | Marketing | `ad_storage`, `ad_user_data`, `ad_personalization` |
   | Necessary | `security_storage` (always granted) |

   *Ask first* (opt-in) = denied until the visitor chooses; *Opt-out* and *No banner* =
   granted. Rows in
   *Per region* get their own default (ISO 3166-2 codes); the main setting applies elsewhere.
   `wait_for_update` 500 ms by default.
6. **The stored choice** of a returning visitor from the `omea_consent_state` cookie
   (`updateConsentState`), straight away. An opt-out region's default record (`_d`) is not
   treated as a choice.

**Every later choice** reaches Google from Omea's own banner code, which the embed line
loads: it sends `gtag('consent', 'update', …)` on each choice. GTM's sandbox can't listen to
window events, so the tag doesn't send these itself.

## Recommended setup

| Site | Use |
|---|---|
| WordPress with Omea Consent | **The plugin alone.** Its head code runs before GTM, so nothing in GTM is needed. Adding this tag is harmless: it sees the plugin's code and steps aside. |
| Page outside WordPress with the Omea embed line in `<head>` (Consent Pro) | The embed line alone – it carries the same head code. |
| Page outside WordPress where **GTM adds the embed line** (or GTM must own Consent Mode) | **This tag** on *Consent Initialization – All Pages*, plus the embed line as a Custom HTML tag. The tag sets the defaults before any other tag; the embed line then skips its own. Use the same consent model and regions as in Omea Consent. |

Limits:

- **Global Privacy Control:** GTM's sandbox can't read `navigator.globalPrivacyControl`, so in
  the *Opt-out* and *No banner* models the tag's defaults grant the ad types also when the
  browser sends GPC. On WordPress the plugin's own head code applies GPC; with this tag,
  use *Ask first* where GPC matters to you.
- The tag reads the cookie name `omea_consent_state` (a site that renamed it with the
  `omea_consent_cookie_name` filter can't use the tag), and it cannot see when Omea re-asks
  because the banner texts changed – until the banner starts and sends its update, the old
  choice stays applied for a moment, as with any cookie-based template.

## Install

GTM › **Templates › Tag Templates › New** › ⋮ › **Import** → `template.tpl` › Save. Then
**Tags › New** › *Omea Consent – Consent Mode*, trigger **Consent Initialization – All Pages**.
Use the same consent model and regions as in Omea Consent.

## Tests

The `___TESTS___` section of `template.tpl` holds the template's tests in GTM's own format,
so GTM's template editor runs them as they are (Tests tab › Run tests).

Outside GTM, with Node.js:

```bash
node tests/run-tests.js
```

`tests/sandbox.js` stands in for GTM's sandbox APIs and enforces the template's declared
permissions; `run-tests.js` runs every scenario plus static checks (sections present,
`___INFO___` complete, every `data.*` field is a parameter, no syntax the sandbox lacks,
LICENSE, metadata.yaml).

## Support

Open an issue in this repository, or see
[cultmetrics.com/support](https://www.cultmetrics.com/support/omea-consent/).

## License

Apache License 2.0 – see [LICENSE](LICENSE). © 2026 Cultmetrics Oy.
