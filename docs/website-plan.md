# Hypercube marketing site — plan & design proposal

Status: proposal, not yet built. Scope is `www.hyper-cube.test` (the quark2 marketing
site) only. `docs.hyper-cube.test` (the Learn2 docs subsite, served from
`src/user/pages-docs` → a symlink to `a-launcher/docs/website`) already works and needs
no content work — see [What already exists](#what-already-exists).

**Decided (owner input, superseding the "Open questions" this plan originally raised):**

- **Production domain**: `www.hyper-cube.app`.
- **Distribution channel**: Play Store.
- **Changelog**: yes, built from the launcher repo's real commit history (see
  [Changelog](#changelog-built-from-real-commit-history) below) — not fabricated. A request
  to backdate it to make the project look like it's been under development since 2020 was
  declined: the real history (2026-05-26 to present, ~920 commits in under 4 months) is both
  honest and a stronger story than a fake six-year arc, and a fabricated founding date is the
  kind of claim that actively erodes trust in exactly the audience this site needs to earn —
  people deciding whether to grant a launcher home-screen-level access to their phone.

## What Hypercube is

Hypercube (`com.codmic.hypercube`) is an Android home-screen launcher whose main UI is a
rotatable 3D cube rendered in OpenGL ES — six faces, each a grid of app icons — instead of
the horizontally-paged 2D screens every other launcher uses. On top of that unusual core it
has grown a large, maximalist feature set: 72 real-time GLSL procedural backgrounds (no
image assets), dozens of "applet" mini-apps that render directly on a cube face (weather,
crypto, QR scanner, tuner, world clock, and more), a hologram long-press menu, folders,
widgets with glass-warp distortion, notification badges, gesture mapping, a four-rung privacy
system (visible/unlisted/locked/vaulted), and JSON backup/restore. It is a solo/indie
project (single `codmic.nl` developer, built with heavy AI-assisted development — see
`a-launcher/CLAUDE.md` and `docs/archive/`), not a company product.

## What already exists

This repo is a stock Grav 2.1.2 install with **two sites sharing one codebase**, split by
Grav's multisite `user/env/<hostname>/` config:

| Host | Theme | Content source | State |
|---|---|---|---|
| `www.hyper-cube.test` (default env) | **quark2** (Grav 2.0's new default) | `src/user/pages` | Skeleton only — two demo pages (`01.home`, `02.typography`) shipped with the theme |
| `docs.hyper-cube.test` | **learn2** | `src/user/pages-docs` → symlink to `a-launcher/docs/website` | **Done.** ~90 pages of real, already-written, already-Learn2-structured docs (chapters, `chapter.md`/`docs.md`, taxonomy) |

`quark2.yaml` already has a real accent color set (`#8428DF`, purple) rather than the
theme default charcoal — someone already made a branding call here worth keeping.
`site.yaml` still has the theme skeleton's placeholder title/author (`Grav` /
`Joe Bloggs`) and needs to become the actual site identity.

This plan is only about the `www` site: turning the quark2 skeleton into an actual
marketing site for Hypercube, and wiring it to the docs subsite that's already finished.

## Design proposal

### The core tension

This is a maximalist, playful, one-person hobby project (72 shader backgrounds, a cube
combination lock, a "vault summon" alias-word search, synthesized tone feedback per
alphabet letter in the contacts scene) — but it also needs to read as a **credible,
installable piece of software**, not a novelty demo, or nobody will trust it enough to
hand it launcher-level access to their phone. The design has to hold both: technical
seriousness (permissions table, no-telemetry stance, real docs) *and* the personality
that makes a rotating 3D cube launcher worth trying over the fifteen boring grid launchers
already on the Play Store.

### Proposed direction: quark2's restraint, Hypercube's motion, as the payload

Quark2 is already the right base for the "credible" half — it's explicitly modeled on
Cal.com's design language: monochrome, generous whitespace, refined shadows, no framework
grid fighting you. Don't fight that. Don't reskin it into a neon cyberpunk dashboard —
that would undercut the "trustworthy enough to be your home screen" read, and it's also
just more work than a two-person indie site plan should take on.

Instead, spend the personality budget on **content and motion, not chrome**:

- **The cube itself is the hero, not a graphic of it.** The single highest-leverage asset
  this site can have is a real screen recording (or WebGL/CSS re-creation, see below) of
  the cube being flung between faces, converted to a short muted looping video/WebM in the
  hero. Quark2's `hero.yaml` supports `parallax`, `overlay-dark`, and fullscreen/large/
  medium/small hero classes — use a dark, large hero with the cube footage as the
  background layer and the pitch as short overlay text. This is a "show, don't tell"
  product — screenshots and a real spin/fling clip do more work than any amount of copy.
- **Let the 72-background catalog be the site's one indulgence.** A `gallery.yaml`-driven
  page (see [Page inventory](#page-inventory)) showing a grid of background thumbnails,
  grouped by the same families already defined in the docs (retro-computing, synthwave,
  liminal, cosmic, cozy, performance-extremes...) is genuinely differentiated content no
  other launcher's site can show, and it's free — the docs already enumerate every
  background by name and family.
- **Purple stays, used sparingly.** Keep `#8428DF` as the one accent quark2 already tints
  links/focus/buttons with. Resist adding a second "sci-fi" palette on top — one disciplined
  accent color reads as considered; a cyberpunk gradient wash reads as trying too hard next
  to Cal Sans/Inter and Blades CSS's clean grayscale base.
- **Dark-first, not dark-only.** Every shader background is designed to be seen against
  black; screenshots will look best on a dark page. Set `theme-mode: dark` (or leave
  `auto` but bias screenshots/hero toward the dark palette) rather than defaulting to
  light and hoping the auto-toggle catches most visitors. Quark2 ships full light *and*
  dark palettes for every component already — no extra theming work, just a default flip.
- **Cube-corner as the one recurring geometric motif**, used the way quark2 already uses
  its accent bar on `h2` — small, structural, not decorative wallpaper. E.g. a thin
  isometric-cube-edge rule between sections instead of a plain `<hr>`. This is optional
  polish, not part of the minimum (see below).

This direction deliberately does *not* propose a custom theme fork, a from-scratch design
system, or heavy JS/3D-in-browser work for v1 — see [Minimum for a professional
site](#minimum-for-a-professional-site) for why, and what to add later if it earns its
keep.

## Page inventory

Mapped to quark2's existing page templates — no new template code needed for any of these.

| Page | Route | Template | Priority |
|---|---|---|---|
| Home | `/` | `modular` (`hero` + `features` + short `text` + CTA) | **MVP** |
| Screenshots | `/screenshots` | `gallery` | **MVP** |
| Features | `/features` | `features` (standard layout, one row per major system: cube, applets, backgrounds, privacy, widgets) — or fold into Home if Home runs long | **MVP** |
| Download | `/download` | `default` or `text` | **MVP** — links to the Play Store listing; see [note](#download-page-note) |
| Privacy Policy | `/privacy` | `default` | **MVP** — required for the Play Store listing |
| Docs | external link to `docs.hyper-cube.test` | n/a | **MVP** (nav link only, zero content work) |
| Backgrounds gallery | `/backgrounds` | `gallery`, grouped by family | Phase 2 |
| Applets showcase | `/applets` | `features` or `blog`-style index | Phase 2 |
| Changelog | `/changelog` | `blog` + `item` | Phase 2 — content authored in `a-launcher/docs/changelog`, symlinked in (see [below](#content-lives-in-a-launcher-not-hypercube-website--same-pattern-as-the-docs)) |
| Press / media kit | `/press` | `text` | Phase 3 |
| 404 | n/a | `error` (theme ships this already) | **MVP**, zero work |

### Home page content, mapped to existing source material

Nothing here needs invention — it's already written in `a-launcher/docs/` and just needs
marketing-voice editing:

- **Hero pitch** — adapt `docs/website/01.home/default.md`'s opening paragraph ("instead
  of scrolling through 2D pages of apps, your apps live on the six faces of a rotatable 3D
  cube").
- **Features grid** (quark2 `features.yaml`: icon + header + short text + link, 3–6 items)
  — pull straight from `FEATURE_LIST_AND_LAUNCHER_COMPARISON.md` §2.1–2.2: the cube itself,
  applets, the 72-background catalog, the four-rung privacy system, widgets, gestures. Each
  card's "link" can point at the matching docs chapter on `docs.hyper-cube.test`.
- **Privacy/trust callout** — this is a real differentiator, not boilerplate: `EXTERNAL_APIS.md`
  confirms *no analytics/crash/telemetry SDK at all* (no Firebase, Crashlytics, Sentry — verified
  against `build.gradle.kts` and a repo grep) and *no background scheduling* — every network
  call is tied to a visible tap or an on-screen repaint. Worth a callout box on Home, not
  just buried in the privacy policy.

### Download page note

No Play Store listing exists yet — nothing in `a-launcher/.github/workflows/` or the repo
indicates a submission has happened, and the 2026-09-12 rebrand/signing-config commits (see
[Changelog](#changelog-built-from-real-commit-history)) read as pre-launch hardening, not a
post-launch changelog. Build the Download page now with a "Coming soon to Play Store" state
(collect an email for a launch ping, or just point at the changelog/docs in the meantime),
and swap in the real Play Store badge/link the moment the listing goes live. Don't invent a
listing URL or a "available now" claim ahead of the actual submission.

## Privacy Policy — content is already sourced, not invented

A Play Store (or F-Droid) listing needs a real privacy policy page, and the launcher repo
already has everything needed to write an accurate one without guessing:

- `docs/archive/EXTERNAL_APIS.md` — authoritative inventory of every outbound network call
  the app makes: `api.open-meteo.com` (weather), `api.coingecko.com` (crypto prices),
  `open.er-api.com` (currency conversion), DuckDuckGo autocomplete, and outbound
  `ACTION_VIEW` intents (WhatsApp, Play Store). All triggered by a visible feature the user
  turned on; nothing fires in the background.
- `docs/website/16.privacy-and-permissions/02.permissions-explained/docs.md` — the runtime
  permissions table (contacts, storage, notification access, accessibility, camera/mic/
  location/sensors), each scoped to "only when you turn on the specific feature that needs it."
- `docs/website/16.privacy-and-permissions/01.hiding-apps-and-privacy/docs.md` — the
  visible/unlisted/locked/vaulted model, useful context (not GDPR content itself, but shows
  privacy-by-design intent).

This gives a policy that can honestly say "no accounts, no analytics SDKs, no ad SDKs, a
short named list of third-party API calls, each tied to a feature you opted into" —
straightforward to write, and something most launcher privacy policies can't honestly
claim. Treat drafting it as content work, not legal guesswork, but **do get an actual human
legal read before publishing** if this ever targets EU users commercially — this plan is
not that.

## Minimum for a professional website

"Professional" here means: a stranger finding this from a Play Store listing or a Reddit
link trusts it enough to install a launcher, and the store review process/App Store-style
policy checks don't bounce it. That bar is lower than most of what's in the [design
proposal](#design-proposal) above — treat that section as the ceiling to grow into, not
the v1 scope.

**Non-negotiable minimum:**

1. `site.yaml` filled in with real title/author/description (currently theme placeholder).
2. Home, Screenshots (or Features-with-images — some visual proof beyond prose), Download,
   Privacy Policy, and a working 404 (already free from the theme).
3. A working nav link to the docs subsite — the docs already exist and are good; not
   linking to them from the marketing site would be leaving a finished asset on the table.
4. Real screenshots or a screen recording of the cube — see [Asset gap](#asset-gap-no-screenshots-exist-yet),
   this currently blocks everything visual.
5. Favicon/logo (quark2 supports `custom_logo`/`custom_logo_mobile`; currently unset,
   falls back to the Grav mark — needs a Hypercube mark before this is public-facing).
6. Basic SEO/social metadata (quark2's `site.yaml` `metadata.description` +
   an Open Graph image) so a shared link doesn't preview as "Grav — an easy to use CMS."
7. Production domain: **`www.hyper-cube.app`** (decided) — `.env`'s
   `TRAEFIK_DOMAIN=hyper-cube.test` is only the local dev domain and needs a prod
   counterpart in the deploy config.

**Explicitly not required for a professional v1** (i.e. don't scope-creep the plan by
adding these before the above is done): the changelog/blog (decided yes, but it's Phase 2 —
see [Changelog](#changelog-built-from-real-commit-history)), a press kit, custom Twig
templates beyond quark2's four modular types, a from-scratch design system, in-browser
WebGL cube demo, dark-mode-only redesign, i18n/translations, a comparison-vs-competitors
page. All reasonable Phase 2/3 additions once the minimum is live.

## Technical setup tasks

Separate from content/design — plain configuration work against the existing quark2 +
Grav setup, no new plugins needed:

- `src/user/config/site.yaml` — real `title`, `author`, `metadata.description`.
- `src/user/themes/quark2/quark2.yaml` → copy to `src/user/config/themes/quark2.yaml`
  before editing (the theme's own README warns direct edits are lost on theme update) —
  set `theme-mode: dark`, `custom_logo`, keep the existing accent color.
- Build out `src/user/pages/` beyond the two demo pages: delete or repurpose
  `02.typography` (theme demo content, not site content) once real pages exist.
- Header/footer nav: add an outbound link to `https://docs.hyper-cube.app` — quark2's nav
  is driven by the page tree, so this is a small `navigation.html.twig` partial override or
  a manual link, not a new page.
- `robots.txt` / sitemap — confirm Grav's defaults are sane for a real launch (currently
  whatever ships with core, unreviewed).
- Add `src/user/env/docs.hyper-cube.app/` mirroring the existing (working)
  `docs.hyper-cube.test` env — same `streams.yaml` (`page` → `user://pages-docs`) and
  `system.yaml` (`theme: learn2`) — plus the `www.hyper-cube.app` production vhost/Traefik
  config alongside the current `.test` one.
- `ln -s /home/leander/Projects/a-launcher/docs/changelog src/user/pages/06.changelog`
  (or whatever numeric prefix fits the final nav order) — same trick as `pages-docs`, one
  level narrower; no `streams.yaml` change needed since it's one subfolder of `www`'s normal
  page tree, not a whole-root swap. See [Changelog](#content-lives-in-a-launcher-not-hypercube-website--same-pattern-as-the-docs).
- Add `a-launcher/docs/changelog` to the `.warden/warden-env.yml` bind-mounts (it currently
  only mounts `a-launcher/docs/website`, read-only, into `php-fpm`/`php-debug`/`nginx`) so
  the new symlink resolves inside the Warden containers the same way `pages-docs` does.

## Asset gap: no screenshots exist yet

Checked `a-launcher/store-assets/` (only `ic_launcher_512.png`) and grepped the whole
launcher repo for screenshots/promo/feature-graphic assets — **none exist**. This is the
single biggest blocker to the design direction above, since the whole pitch is "show,
don't tell" for a highly visual product. Before Screenshots/hero-video work can start,
someone needs to:

1. Run the app on a device/emulator and capture: the cube mid-spin, a couple of face
   layouts, the hologram menu open, a few applets (weather, crypto, tuner are visually
   distinct), the backgrounds gallery in Settings, the widget panel's glass-warp effect.
2. Ideally a 10–20s screen recording of a fling-and-snap cube rotation for the hero video.
3. Export/re-render the launcher icon at web resolution for the site favicon/logo (only a
   512px mipmap source exists today, plus adaptive-icon XML layers — fine for exporting a
   clean PNG/SVG mark).

This plan does not attempt to generate those assets — it's a capture task against the
running app, not a website task.

## Changelog, built from real commit history

`a-launcher`'s `git log` is the source of truth — 919 commits, `2026-05-26` to
`2026-09-14` (today), almost entirely in a `feat(scope): ...` / `fix(scope): ...`
conventional-commit style, which makes them easy to theme without inventing anything.
Below is that history clustered into eight real version milestones by week and feature
theme (raw commit counts per ISO week ran 128 → 2; grouping by theme reads far better than
one entry per commit). Dates are real `git log --date=short` output, not estimates.

One real gap is worth keeping rather than smoothing over: **no commits from 2026-07-20 to
2026-07-28.** A four-month changelog with zero pauses would itself look manufactured; a
nine-day break after shipping the big v0.4 platform-integration batch is a normal, credible
rhythm for a solo project and costs nothing to be honest about.

| Version | Dates | Theme | Sourced from (representative commits) |
|---|---|---|---|
| v0.1 — First Spin | 2026-05-26 – 05-31 | GLSurfaceView cube renderer, drag-to-rotate gestures, icon texture atlas, first configurable grid density/icon padding | `Initial commit`; `Step 1`–`Step 5` (launcher setup → gestures & procedural texture mapping); `Add configurable grid density, icon padding, and improved pagination` |
| v0.2 — Search, Dock & Badges | 2026-06-01 – 06-14 | App search (cube + explode grid), configurable dock, drag drop-target highlight, notification badges | `implement dynamic app search for 3D Cube and 2D Explode Grid`; `add configurable dock and fix search placement behavior`; `Implemented projected cube drop target highlight`; `Add app badges to 2d grid and cube` |
| v0.3 — Folders, Widgets & Hologram | 2026-06-15 – 07-05 | Folders, widget panel slots/UI, hologram-menu icon loader, first contacts implementation | `Add folders implementation plan docs, first implementation`; widget slot/UI fixes throughout W25; `Add hologram loader when updating icons after OEM icon setting change`; `First implementation of contacts` |
| v0.4 — Platform Integration | 2026-07-06 – 07-19 | Real-time package-change detection, app shortcuts, pin-shortcut/widget hosting, in-launcher uninstall, work-profile support, set-as-default flow, backup/restore, onboarding tour + layout lock, 40 audio presets | The 07-18 batch closing items 2.1–2.6 (`PackageChangeWatcher`, `AppShortcutsManager`, `PinShortcutActivity`, uninstall via hologram menu, multi-profile via `LauncherApps`, default-launcher prompt) plus backup/restore; `First-run onboarding tour + layout lock (4.4/4.5)`; `40 new audio presets` |
| v0.5 — Applets Arrive | 2026-07-29 – 08-13 | The on-cube applet scene launches; first applet wave; three new background packs; fidget-spinner scene begins | `add an on-cube applet scene with interactive faces`; `Import audio file to decode Morse in Morse Tone Generator`; `Add Currency mode to UnitConverterApplet`; `Implement RecursivePack backgrounds`; `Implemented the Optical Machine Pack`; `Implemented the Liquid Light Pack backgrounds`; `Add FidgetSpinner geometry class` |
| v0.6 — Applet Explosion | 2026-08-18 – 08-30 | Applet placement/accessibility actions, PDF viewer annotations, Speak applet, fidget-spinner characters, richer reminders | `Implement applet placement removal and accessibility actions`; `Add annotation support with highlights, ink, and notes` (PDF viewer); `Speak immediately on Enter without closing the keyboard`; `Add the Dino/Froggy character design`; `Enhance reminder functionality with repeat scheduling and alarm management` |
| v0.7 — Privacy Rungs & Smart Sorting | 2026-08-31 – 09-06 | Smart app categorization, scheduled backups, several finance/time applets, vaulted-app summon-by-word | `AppCategorizer — the rules behind smart categorization`; `Scheduled backups to a folder`; `Crypto holdings and a world-clock meeting planner`; `Summon a vaulted app by word, and carry isFaceVisible into tiles` |
| v0.8 — Becoming Hypercube | 2026-09-07 – 09-14 (today) | Gesture flip/wave slots, device/network monitor applets, minSdk 26, **rebrand from ALauncher to Hypercube**, release hardening, this documentation site | `Flip and wave as gesture slots`; `A per-app data usage monitor`; `A Wi-Fi signal monitor`; `Raise minSdk to 26 and delete the guards it makes dead`; `rebrand(app): Rename ALauncher to Hypercube (com.codmic.hypercube)`; `A real Hypercube app icon, replacing the system placeholder`; `Signing config, R8 minification, disable auto-backup`; `Add documentation that will be published on the Grav website` |

**The rebrand is a real, usable story, not just a fact to disclose.** The project was
called **ALauncher** for effectively its entire development history and only became
**Hypercube** on 2026-09-12 — three days before this plan — alongside the release-signing
config, the real app icon, and opinionated fresh-install defaults. That's a genuine "this
is the moment it stopped being an experiment and started being a product" beat, worth a line
on the changelog or an About section rather than something to paper over. (The repo
directory is still named `a-launcher` for exactly this reason.)

**What this changelog is *not***: a record of Play Store releases — none have happened yet
(see the [Download page note](#download-page-note)). Frame it as build/development history
("what's new in each milestone") rather than "released on this date," and add a genuine
v1.0 entry when the Play Store listing actually goes live — not backdated, whenever that is.

### Content lives in `a-launcher`, not `hypercube-website` — same pattern as the docs

Confirmed this against quark2's actual blog/item blueprints: a Grav blog is just a `blog.md`
index (`child_type: item`, ordered by a plain `date:` frontmatter field) plus one folder per
entry containing an `item.md`. Nothing about that format is quark2-specific or
website-repo-specific — it's the same shape as `docs.md`/`chapter.md` already is for Learn2.
So the changelog should live at **`a-launcher/docs/changelog/`**, authored the same way
`a-launcher/docs/website/` already is, and be reachable from the `www` site the same way
`pages-docs` is reachable from the docs env — just one level narrower:

```
a-launcher/docs/changelog/
  blog.md                          # index — title, child_type: item, order by date desc
  01.first-spin/item.md            # date: 2026-05-26, title: v0.1 — First Spin
  02.search-dock-badges/item.md    # date: 2026-06-01, title: v0.2 — Search, Dock & Badges
  ...
  08.becoming-hypercube/item.md    # date: 2026-09-07, title: v0.8 — Becoming Hypercube
```

```
hypercube-website/src/user/pages/06.changelog -> a-launcher/docs/changelog   # symlink
```

This is a plain nested-folder symlink inside the real `src/user/pages/` tree, not a
`streams.yaml` stream override — `pages-docs` needed a stream override because it replaces
the *entire* page root for a different hostname/env; this only needs to replace one
subfolder within the `www` site's normal page tree, so a symlink at that one path is
sufficient (same trick, one level deeper, no env/stream config needed). Add it in
[Technical setup tasks](#technical-setup-tasks) alongside the existing `pages-docs` link and
the `.warden/warden-env.yml` bind-mount that makes `a-launcher/docs/website` visible inside
the Warden containers (a matching mount for `a-launcher/docs/changelog` is needed too).

The real payoff of this, beyond consistency: it makes the changelog a living thing instead
of a one-time backfill. Once this initial set of entries is committed, **adding the next
one becomes part of shipping a feature in `a-launcher`** — whoever cuts the next real
milestone writes its `item.md` alongside the code, commits it to `a-launcher`, and it
appears on the website with zero commits to `hypercube-website` — exactly the win
`docs/website` already gets from being symlinked instead of copy-pasted.

### Tone: two sample entries, commit log → site copy

The table above is sourcing material, not copy — the actual page needs a marketing-voice
pass. For example:

> **v0.1 — First Spin** · *May 2026*
> The very first build: a GPU-rendered cube you can drag and fling between faces, with your
> real installed apps on it. No settings screen to speak of yet — just the core idea,
> proven out.

> **v0.8 — Becoming Hypercube** · *September 2026*
> ALauncher becomes **Hypercube**. A real app icon, hardened release build, and sensible
> defaults out of the box — the project's transition from "personal experiment" to
> something ready to hand to someone else.

## Suggested phasing

- **Phase 0 — foundation**: `site.yaml`/`quark2.yaml` config, logo/favicon, capture real
  screenshots, draft the privacy policy from the sourced material above.
- **Phase 1 — MVP launch**: Home, Screenshots, Download, Privacy Policy, docs nav link,
  404 (free). This satisfies the "minimum for professional" bar.
- **Phase 2 — differentiation**: Backgrounds gallery, Applets showcase, Changelog (content
  sourced above) using quark2's `blog`/`item` templates.
- **Phase 3 — nice-to-have**: press kit, cube-corner motif polish, comparison content.

## Remaining open question

- **F-Droid or direct APK, in addition to Play Store?** Not decided — no release workflow
  exists yet in `a-launcher/.github/workflows/` either way. Doesn't block v1 (the Download
  page can ship Play-Store-only and grow a second option later), but worth a decision before
  Phase 1 locks in the Download page's final layout.
