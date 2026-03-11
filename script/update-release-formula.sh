#!/bin/bash
set -euo pipefail

usage() {
  cat <<'EOF'
usage: script/update-release-formula.sh <version> <sha256>

Example:
  script/update-release-formula.sh 1.1.0 abcdef...
EOF
}

[ $# -eq 2 ] || {
  usage >&2
  exit 1
}

VERSION="$1"
SHA256="$2"
FORMULA="Formula/mac-mp4-screen-rec.rb"

[[ "$VERSION" =~ ^[0-9]+(\.[0-9]+)*$ ]] || {
  echo "error: version must look like 1.1.0" >&2
  exit 1
}

[[ "$SHA256" =~ ^[0-9a-f]{64}$ ]] || {
  echo "error: sha256 must be 64 lowercase hex characters" >&2
  exit 1
}

[ -f "$FORMULA" ] || {
  echo "error: formula not found at $FORMULA" >&2
  exit 1
}

perl -0pi -e 's|url "https://github.com/arch1904/MacMp4ScreenRec/archive/refs/tags/v[^"]+\.tar\.gz"|url "https://github.com/arch1904/MacMp4ScreenRec/archive/refs/tags/v'"$VERSION"'.tar.gz"|g' "$FORMULA"
perl -0pi -e 's|sha256 "[0-9a-f]{64}"|sha256 "'"$SHA256"'"|g' "$FORMULA"
perl -0pi -e 's|version "[^"]+"|version "'"$VERSION"'"|g' "$FORMULA"

ruby -c "$FORMULA"
echo "Updated $FORMULA to v$VERSION"
