---
title: Privacy Policy
---

# Privacy Policy

*Last updated: 2026-10-20.*

This policy covers the Hypercube Android app (`com.codmic.hypercube`), this website, and the small
data service the app uses (`data-proxy.hyper-cube.app`). It lists what is processed, where it goes,
and why. It was written from the app's own code and its inventory of network calls, not from a
template.

## Who is responsible

Hypercube is developed and published by **Codmic**, run by Leander.

- Address: Peperstraat 32, 5554 EK Valkenswaard, the Netherlands
- Chamber of Commerce (KvK): 77115899
- Contact, including for privacy requests: **support@hyper-cube.app**

## The short version

- **No account, sign-up or login.** There is nothing to register.
- **No analytics, crash-reporting or advertising SDK.** The app contains no Firebase, Crashlytics,
  Sentry or ad library, and Hypercube does not collect usage data.
- **Offline by default.** The app makes no network request until you use a feature that needs one,
  such as placing the Weather applet or turning on web search suggestions.
- **Your layout, settings and everything you type into an applet stay on your device.** Backups you
  create are files in a folder you choose. Hypercube does not upload them anywhere.
- **Support requests are the one thing stored on our side.** If you send one from Help & Support, we
  keep what you wrote so we can answer it, and delete it on a fixed schedule or as soon as you ask (see
  [Support requests](#support-requests)).
- **The only background network activity** is the optional crypto price alert, and only after you
  set an alert on a Crypto tile (see below).

## Permissions, and why each is requested

Permissions are requested at the point you turn on the feature that needs them, never all at launch.

| Permission | Used for | Requested when |
|---|---|---|
| Internet, network state | The features in the next section; reachability checks | Always declared; used only as described below |
| Contacts | Contact search, Quick Dial and similar | You enable contacts search or place a contacts applet |
| Calendar | Calendar results in search and the Agenda applet | You enable calendar search or place that applet |
| Files / storage (before Android 13) | File search | You enable file search |
| Usage access | Usage-based app sorting, Screen Time applet | You choose that sorting or place that applet |
| Notification access | Badges on icons | You enable badges, through Android's own settings screen |
| Accessibility service | The Recents and Lock-screen gestures only | You assign one of those gestures and agree in the in-app disclosure; the service does not read the screen or what you type |
| Location (precise or approximate) | Weather for where you are; compass and similar | You place an applet that needs it and allow the prompt |
| Camera | QR scanner, flashlight and similar | You place that applet |
| Microphone | Tuner, voice memos and similar | You place that applet |
| Physical activity, NFC, Bluetooth, Wi-Fi state | Step counter, NFC actions, network tools and similar | You place that applet |
| Notifications, exact alarms, full-screen intents | Alarm, timer and reminder applets | You use those applets |
| Run on boot | Re-arm alarms and reminders after a restart | Used by those applets |

Turning a feature off stops Hypercube using the permission, but Android keeps the grant until you
revoke it in the system settings.

Contacts, calendar, location, camera, microphone, activity and usage data are processed **on your
device** and are not sent to us. The one exception is the coordinates described under Weather, which
are sent to produce a forecast.

## What the app sends over the network, and to whom

This is the complete list. Anything not here does not happen.

Several features go through our own data service, **`data-proxy.hyper-cube.app`**, which runs on
bunny.net (BunnyWay d.o.o., Slovenia). It exists so that our provider keys stay out of the app and so
that requests are pooled, and it is described in its own section below. In every row, the server you contact sees your **IP
address**, because that is how the internet works.

| Feature | Sent to | What is sent | When |
|---|---|---|---|
| Weather applet: forecast, air quality, marine, flood, history | `data-proxy.hyper-cube.app`, which asks Open-Meteo | The coordinates of the place: your device location if you allowed it, or the coordinates of a city you saved | While a Weather tile or its fullscreen view is on screen; results are cached on the device |
| Weather applet: adding a city | The same, to Open-Meteo's geocoding service | The city name you typed | When you search for a city |
| Crypto prices (USD) | `data-proxy.hyper-cube.app`, which asks CoinMarketCap | Nothing about you or your coins. The app downloads one shared top-200 list and does the matching on your phone | While a Crypto (USD) tile or its fullscreen view is on screen; in the background only for a price alert |
| Crypto prices (EUR) | `data-proxy.hyper-cube.app`, which asks Bitvavo | Nothing about you or your coins. The app downloads the full market list and filters it on your phone | Same as above |
| Help & Support (Settings → About) and the Support applet | `data-proxy.hyper-cube.app` (our own service; nothing is passed on) | Opening it fetches the public help list and checks your open requests for replies. Sending a request sends its category, an optional subject, your message, an optional email address and, only if you tick the box after seeing a preview, app version, Android version, device model and language | Only while the Support screen is open; nothing in the background |
| Unit Converter, currency mode | `open.er-api.com` (ExchangeRate-API) | Nothing beyond the request itself: one shared rate list | While the currency view is on screen; cached for 12 hours |
| Search bar, web suggestions (**off by default**) | `duckduckgo.com` | What you type after the web-search prefix, as you type | Only if you turn the setting on |
| Search bar, "search the web" | The search engine you chose | Your query, sent by your browser | When you tap the result |
| Translate applet, language packs | Google (ML Kit model download) | A request for the language pack you picked, about 30 MB, once per language | When you add a language. Translation itself runs on your device and your text is not sent |
| Fonts that are not bundled | Google Fonts, through Google Play Services | The font name | When you select or preview such a font |
| RSS reader, podcast and radio, HTTP scratchpad, DNS, ping and TLS tools, file harvester | The addresses **you** enter | What those tools send to the address you entered | When you use them |
| Local file transfer and network scanner | Devices on your local network | File transfer is between devices you choose, over your own network; Hypercube has no server involved | When you use them |
| WhatsApp action, Play Store fallback | The WhatsApp or Play Store app on your phone | A link handed to that app by Android | When you tap the action |

The providers behind the data service have their own policies: Open-Meteo, CoinMarketCap and Bitvavo
by way of our service; ExchangeRate-API, DuckDuckGo and Google directly. Please read theirs if you
use the matching feature. Hypercube has no control over what they do with the requests they receive.

## Background activity

Hypercube checks something in the background in a few cases. Battery, storage and screen-time alerts
read your own device and use no network. Alarms, timers and reminders are scheduled on the device and
use no network.

The one background network activity is the **crypto price alert**. If you set a price alert on a
Crypto tile, Android runs a check about every 15 minutes or less often, even while the launcher is
closed, and it fetches the same shared price list as above. Removing the alert stops the check.

## The data service (`data-proxy.hyper-cube.app`)

- It forwards only a fixed list of requests (weather, one crypto price list, one Bitvavo market list),
  and handles support requests itself. Anything else is refused.
- **Coordinates are rounded to two decimal places (about 1 km) before they are forwarded or used as a
  cache key.** Rounding reduces precision; it does not make a location anonymous. The app sends the
  coordinates unrounded and the service rounds them on receipt.
- **No request log.** The service's own code writes none, and bunny.net's access logging is switched
  off for it. bunny.net, as the infrastructure provider, still handles your IP address to deliver the
  service. Its firewall (Bunny Shield) uses your IP address to limit how many support requests one
  address can send in a short time, and may record the address of a request that trips one of its
  protection rules.
- The weather, crypto and market providers see **bunny.net's address, not yours**. For the crypto
  lists they receive no information about you at all.
- **City names you search for** are forwarded and are part of the cached request, so a search term
  can sit in the service's cache.
- **Retention:** answers are cached for 15 minutes (forecast), 30 minutes (air quality), 1 hour
  (marine), 6 hours (flood and the Bitvavo coin list), 24 hours (history, city search), 10 minutes
  (CoinMarketCap list) or 60 seconds (Bitvavo prices). A last good copy of each answer is kept up to
  **24 hours** so the app still has something to show when the data provider is down. These are
  answers to rounded or parameter-free requests, not per-person records.

## Support requests

You can ask a question, report a problem or suggest a feature from Help & Support (Settings → About) or
the Support applet. There is no account behind it.

- **What we store:** the category, the optional subject, the messages (yours and our replies), the email
  address if you gave one, and the device details if you chose to include them (app version, Android
  version, device model and language, shown to you before sending). We also store when each message was
  written.
- **What we do not store:** your IP address, a device ID, an advertising ID or anything else that
  identifies your phone. The request is protected by a key your phone creates; we keep only a one-way
  hash of it, so we cannot open a request on your behalf, and the request number alone gives access to
  nothing.
- **Where:** in a database at bunny.net, in Frankfurt, Germany.
- **Who reads it:** the developer, to answer you. When we get a new request or message, our
  notification carries only the request number and category, never what you wrote.
- **How long:** a closed request is deleted 180 days after its last activity, and an open request after
  365 days without activity. Closing a request erases its email address straight away. You can delete a
  request yourself at any time from the app, which removes it from the database at once. bunny.net keeps
  backups of the database, so deleted data can remain in a backup for a limited time before it is
  overwritten.

## Legal basis

Using a feature that needs the network is what you asked for when you placed or opened it, so the
basis is performing that request (GDPR Art. 6(1)(b)). Where a feature is switched on by a setting, such
as web search suggestions, the basis is your consent (Art. 6(1)(a)), which you can withdraw by
switching the setting off. Handling a support request you send is performing that request too
(Art. 6(1)(b)); including device details is your consent (Art. 6(1)(a)), given by ticking the box.
Running and protecting the data service and this website, including rate limits, rests on our
legitimate interest in keeping them working and secure (Art. 6(1)(f)).

## Transfers outside the EU

bunny.net is a European company and keeps support requests in Germany. Like any content delivery
network, it answers each request from the server nearest to you, which outside Europe is outside the
European Economic Area. Google, CoinMarketCap, ExchangeRate-API, DuckDuckGo and Cloudflare (which serves one stylesheet on this website) may process data
on servers outside the EEA, including in the United States. Where they do, they rely on a transfer
mechanism such as the EU-US Data Privacy Framework or Standard Contractual Clauses. Bitvavo is a Dutch
company and receives no information about you.

## Data that stays on your device

- Your layout, dock, folders, hidden or locked app assignments and every setting.
- Anything you enter in an applet: notes, expenses, reminders, health entries, voice memos and similar.
  Applets that hold sensitive text can additionally encrypt it on the device.
- Backups (Settings → Backup & Restore) are files written to a folder you choose. They can be
  password-protected. Hypercube does not upload them.

This data stays until you delete the item, reset the app or uninstall it. You can export it with
Backup & Restore and erase it with Factory Reset.

## Vaulted and locked apps

The privacy levels (visible, unlisted, locked, vaulted) control what Hypercube shows and when. They are
not encryption of other apps' data. Unlocking relies on your device's own screen lock; Hypercube never
asks you to create a separate passcode and never sees your device credential. The
[Privacy & Permissions documentation](https://docs.hyper-cube.app/privacy-and-permissions) explains the
limits.

## Your rights

Under the GDPR you have the right to access, correct and erase your data, to restrict or object to its
processing, and to receive it in a portable form. Almost everything Hypercube holds is on your device,
where you already control it with Backup & Restore and Factory Reset. On our side we hold the
short-lived cached answers above, which are not linked to a person, and the support requests you sent.
You can read and delete your own requests in the app at any time. Because there are no accounts, we can
only find a request for you if you tell us its number (it starts with `HC-`). For anything else write to
**support@hyper-cube.app**.

You may also complain to a data protection authority. In the Netherlands that is the
[Autoriteit Persoonsgegevens](https://autoriteitpersoonsgegevens.nl).

## This website

The website sets no cookies of its own and has no analytics or advertising. Its pages load one icon
stylesheet (Font Awesome) from `cdnjs.cloudflare.com`, so Cloudflare receives your IP address when you
open a page. Our host and bunny.net, whose network sits in front of the site, also process visitor IP
addresses to serve and protect it.

## Children

Hypercube is not aimed at children and does not knowingly collect personal data from anyone. It has no
accounts and no age check because it has no data collection to apply one to.

## Changes

If what Hypercube collects or sends changes, this page changes with it and the date at the top is
updated.
