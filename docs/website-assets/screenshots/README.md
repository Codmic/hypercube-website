# Screenshot capture notes

Captured 2026-09-14, via `adb`, from a **clean API 29 Android emulator** (`api29_biotest`
AVD), not the connected personal device. That distinction matters: the connected real
device is the owner's daily-driver phone, and its actual home grid contains real personal
apps (banking, messaging, shopping accounts) — confirmed by an internal triage screenshot
that was deleted immediately after viewing and never left this machine. None of the files
in this folder come from that device or contain any personal data; everything here was
generated on a disposable emulator profile with only stock AOSP/Google apps installed.

## How these were made

1. Installed the already-built `app/build/outputs/apk/debug/app-debug.apk` onto the `api29_biotest`
   emulator (booted headless: `emulator -avd api29_biotest -no-window -no-audio -no-boot-anim`).
   Note: the other available AVD, `Pixel_9` (a "Page Size 16KB" experimental image), could not
   resolve/launch the app's activities at all — a platform-image quirk, not an app bug. Use
   `api29_biotest` or a similar standard (non-16KB-page) image.
2. Set Hypercube as the emulator's default home app via the normal system role-request dialog
   (triggered automatically by the app's own onboarding ~1.2s after first launch).
3. For screens not reachable by tapping through safely (specific applets, specific settings
   tabs), used direct `adb shell am start` intents instead of blind taps, e.g.:
   - `am start -n com.codmic.hypercube/.ui.main.LauncherActivity -e com.codmic.hypercube.extra.FOCUS_APPLET_TOKEN <id>`
     opens any applet (`weather`, `compass`, `calculator`, ...) fullscreen directly, whether
     or not it's placed on a face — see `LauncherActivity.EXTRA_FOCUS_APPLET_TOKEN`.
   - `SettingsActivity` is not exported, so it has to be reached by tapping the in-app gear
     button — its exact tap coordinates were found via `uiautomator dump` rather than guessed.
4. Captured with `adb exec-out screencap -p`.

## Known limitations of this batch — treat as a first pass, not final assets

- **The cube looks sparse.** A fresh AVD only has ~18 stock launchable apps (Chrome, Camera,
  Contacts, Gmail, Maps, YouTube, ...), and Hypercube's fresh-install default is a 1×1 grid,
  so most faces show a single icon. Real marketing screenshots will want either a denser
  default grid size (Settings → Cube → Grid Size) or more apps installed on the emulator
  before recapturing `05-home-cube-face1.png`-style shots.
- **`08-settings-backgrounds.png`'s live perf readout** ("48 fps on a 60Hz screen ... 21%
  over budget, dropping frames") reflects this emulator's slow `swiftshader` **software**
  GL rendering, not real hardware performance — don't use that specific panel as-is; either
  crop it out or recapture on a real device (or an emulator with proper GPU passthrough).
- No hologram menu, folder, widget-panel, or hero spin/fling shots yet — those need either
  a long-press/drag gesture sequence scripted over `adb shell input`, or manual capture.
  Same for anything requiring the Contacts or notification-badge scenes — **do not** capture
  those from the real device; if needed, seed fake contacts on a clean emulator instead.

## Files

| File | Content |
|---|---|
| `01`–`04` | First-run onboarding tour (4 pages) |
| `05` | Home cube, face 1 |
| `07` | Launcher Settings — Cube tab |
| `08`–`09` | Launcher Settings — Backgrounds tab (performance panel, per-background sliders) |
| `10` | Backgrounds catalog dropdown — a real slice of the 72-background list |
| `11` | Weather applet, with its default seeded cities (New York/LA/London — sample data, not a real user's) |
| `12` | Compass applet |
