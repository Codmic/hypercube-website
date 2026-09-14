---
title: Privacy Policy
---

# Privacy Policy

*Last updated: 2026-09-14.*

Hypercube is an Android home-screen launcher developed by Leander (codmic.nl). This page
describes, plainly and completely, what data the app touches and where it goes. It's sourced
directly from the app's own code and network-call inventory, not written from a template.

> [!NOTE]
> Questions about this policy? Contact **info@codmic.nl**.

## The short version

- **No account, no sign-up, no login.**
- **No analytics, crash-reporting, or telemetry SDK of any kind** — no Firebase, no
  Crashlytics, no Sentry, nothing that phones home about how you use the app.
- **No ad SDKs.**
- **Nothing runs in the background.** There is no scheduled or periodic network activity of
  any kind. Every network request Hypercube makes is tied to a feature you actively tapped
  on, or to a repaint of a face/screen that is currently visible.
- Your app layout, settings, and any applet data you enter are stored **locally on your
  device**. Backups you create are exported to a folder you choose, on your device — never
  uploaded anywhere by Hypercube itself.

## Permissions, and exactly why each one is requested

Hypercube requests permissions narrowly: only for a feature you've actually turned on, and
only at the point you turn it on — never all at once at first launch.

| Permission | Requested when |
|---|---|
| Internet / network state | Any of the features below that talk to a server, plus web search |
| Contacts | You enable contacts as a search source, or use a contacts-related applet (e.g. Quick Dial) |
| Storage / files (pre-Android 13) | You enable file search |
| Usage access | You choose usage-based app sorting |
| Notification access | You enable badges — requested via its own dedicated system screen, not a normal permission dialog |
| Accessibility service | You assign a gesture to a system action (recents, lock screen) |
| Bind app widget | You add a widget to the widget panel |
| Location, camera, microphone, sensors | Only when you place a specific applet that needs it (compass, QR scanner, voice memos, pitch detector, and similar) — never requested for the launcher generically |

Turning a feature back off stops Hypercube from using the permission immediately, though it
doesn't automatically revoke a previously granted Android permission — that's an OS-level
control, available in your device's own Settings.

## Every outbound network request Hypercube makes

This is the complete list. There is nothing else — no analytics beacon, no update-check
ping, no background sync.

| Service | Feature | What's sent | Trigger |
|---|---|---|---|
| `api.open-meteo.com` | Weather applet — conditions | The city's coordinates | While a Weather tile or its fullscreen view is on screen (cached 30 min) |
| `geocoding-api.open-meteo.com` | Weather applet — add a city | The city name you typed | Tapping "+ Add city" |
| `api.coingecko.com` | Crypto applet — prices | The coin(s) you're tracking | While a Crypto tile or its fullscreen view is on screen (cached 60s) |
| `api.coingecko.com` | Crypto applet — search | The search text you typed | Tapping "+ Add coin" |
| `open.er-api.com` | Unit Converter — currency mode | Nothing identifying — a single shared rate fetch | While the currency mode view is on screen (cached 12h) |
| `duckduckgo.com` | Search bar — autocomplete suggestions | What you're typing, once you prefix a query with `/` for a web search | Each keystroke of a `/`-prefixed query |
| Your chosen web search engine | Search bar — "search the web" | Your search query | Tapping a web-search result |
| `wa.me`, `play.google.com` / `market://` | A contact's WhatsApp action, or the Play Store fallback for an app | n/a — opens the relevant app via an Android Intent | Tapping that specific action |

None of these run unless you're actively using the specific feature they belong to — closing
the launcher or backgrounding it stops all of them.

## Data that stays on your device

- Your cube layout, dock, folders, hidden/locked/vaulted app assignments, and every setting
  you change.
- Any data you enter into an applet (notes, expense entries, reminders, and similar) — for
  applets that store sensitive text, you can additionally opt into encryption-at-rest for
  that applet's saved data.
- Backup exports (Settings → Backup & Restore) are written as a file to a folder you choose
  on your own device or its attached storage. Hypercube does not upload backups anywhere.

## Vaulted and locked apps

Hypercube's privacy rungs (visible / unlisted / locked / vaulted) are a display and
access-gating feature, not encryption of other apps' data. Unlocking a locked or vaulted
item is backed by your device's own screen lock (biometric or PIN/pattern/password) —
Hypercube never asks you to create a separate in-app passcode, and never sees your device
credential. See the [Privacy & Permissions documentation](https://docs.hyper-cube.app/privacy-and-permissions)
for the honest limits of what this feature does and doesn't protect against.

## Children's privacy

Hypercube does not knowingly collect personal information from anyone, and has no age
gate, account system, or data collection to apply one to.

## Changes to this policy

If what Hypercube collects or sends changes, this page will change with it, and the "Last
updated" date at the top will reflect that.
