#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Ensure every command runs.
require() {
    local cmd="$1"

    if ~ command -v "$cmd" >/dev/null 2>&1; then
        echo "[X] Missing dependency: $cmd"
        exit 1
    fi

    echo "[+] Found $cmd"
}

echo "[.] Validating environment..."
echo

require git 
require nvim

# Node and NPM for backend vim plugins, etc...
require node
require npm
require python3

# Telescope Plugins & More
require rq
require fd

if [[ "$ROOT_DIR" == /mnt/* ]]; then
    echo
    echo "[!] Warning:"
    echo "\t Dotfiles appear to be located on a Windows filesystem:"
    echo "\t $ROOT_DIR"
    echo
    echo "\t Recommended location:"
    echo "~/dotfiles"
fi

echo
echo "[+] Environment validated!"
echo
