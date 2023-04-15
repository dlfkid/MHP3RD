#!/bin/bash
# Usage: bootstrap

set -eu

ROOT="$(dirname "$PWD")"
HOOKS_FOLDER="$ROOT/.git/hooks"
if [[ -d "$HOOKS_FOLDER" ]] && [[ ! -L "$HOOKS_FOLDER" ]] ; then
echo ">>> remove default hooks directory."
mv "$HOOKS_FOLDER" "$ROOT/.git/hooks_bak/"
fi

if [[ ! -d "$HOOKS_FOLDER" ]] || [[ ! -L "$HOOKS_FOLDER" ]] ; then
echo ">>> create hooks symbolic link."
ln -s "$ROOT/format_hooks/hooks/" "$ROOT/.git"
fi
 
chmod -R +x "$ROOT/format_hooks/hooks/"