#!/usr/bin/env bash

set -euo pipefail

echo "Bootstrapping Neovim..."
echo

if ! command -v nvim >/dev/null 2>&1; then
    echo "Skipping Neovim bootstrap (nvim not installed)"
    exit 0
fi

nvim --headless "+Lazy! sync" +qa

echo
echo "[+] Lazy.nvim plugins synced"
echo
