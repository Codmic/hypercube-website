#!/usr/bin/env bash
#
# Restores the Grav core distribution into src/. src/system, src/bin,
# src/vendor, src/index.php, root metadata, etc. are the getgrav/grav
# project itself, not this site, and aren't tracked in git (see
# src/.gitignore) — this script re-fetches them from the official release.
#
# Site content (src/user/) is never touched. Safe to re-run.
#
# Usage: bin/setup-grav.sh [version]
#   GRAV_VERSION env var or first arg overrides the pinned version below.

set -euo pipefail

GRAV_VERSION="${1:-${GRAV_VERSION:-2.1.2}}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SITE_ROOT="$ROOT_DIR/src"
ZIP_URL="https://github.com/getgrav/grav/releases/download/${GRAV_VERSION}/grav-v${GRAV_VERSION}.zip"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

echo "==> Downloading Grav core ${GRAV_VERSION}"
curl -fSL "$ZIP_URL" -o "$TMP_DIR/grav.zip"

echo "==> Extracting"
unzip -q "$TMP_DIR/grav.zip" -d "$TMP_DIR/extracted"

echo "==> Syncing core into src/ (user/ left untouched)"
rsync -a \
  --exclude '/user/' \
  --exclude '/vendor/' \
  --exclude '/backup/' \
  --exclude '/cache/' \
  --exclude '/images/' \
  --exclude '/logs/' \
  --exclude '/tmp/' \
  --exclude '/assets/' \
  "$TMP_DIR/extracted/grav/" "$SITE_ROOT/"

if command -v composer >/dev/null 2>&1; then
  echo "==> Installing Composer dependencies"
  (cd "$SITE_ROOT" && composer install)
else
  echo "==> composer not found on PATH — run 'composer install' inside src/"
  echo "    (e.g. via the Warden PHP container) to build vendor/."
fi

echo "==> Done. Grav ${GRAV_VERSION} core restored."
echo "    Note: this release package doesn't include Grav's own dev/CI"
echo "    files (tests/, .phan/, codeception.yml, .github CI workflows)."
echo "    Those aren't needed to run the site; they're only relevant if"
echo "    you're hacking on Grav core itself."
