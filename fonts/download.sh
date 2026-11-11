#!/usr/bin/env bash
# Download the Nerd Font used by kitty. Safe to rerun: skips files that exist.
set -euo pipefail

FONT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
FONT_NAME="CaskaydiaCoveNerdFont-Regular.ttf"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/CascadiaCode/Regular/$FONT_NAME"

if [ -f "$FONT_DIR/$FONT_NAME" ]; then
  echo "  ok: $FONT_DIR/$FONT_NAME already present"
else
  echo "  downloading $FONT_NAME"
  curl -fL --retry 3 "$FONT_URL" -o "$FONT_DIR/$FONT_NAME.part"
  mv "$FONT_DIR/$FONT_NAME.part" "$FONT_DIR/$FONT_NAME"
fi

echo "  install it by hand for glyphs: open \"$FONT_DIR/$FONT_NAME\""
