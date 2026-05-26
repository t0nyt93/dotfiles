#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

link() {
    local source="$1"
    local target="$2"

    mkdir -p "$(dirname "$target")"

    if [[ -L "$target" ]]; then
        rm "$target"
    elif [[ -e "$target" ]]; then
        mv "$target" "${target}.bak.$(date +%s)"
    fi

    ln -s "$source" "$target"

    echo "[+] Linked $target"
}

echo "Creating symlinks..."
echo

link "$ROOT_DIR/nvim" "$HOME/.config/nvim"
link "$ROOT_DIR/zellij" "$HOME/.config/zellij"
link "$ROOT_DIR/zsh/.zshrc" "$HOME/.zshrc"

echo
echo "[+] Symlink setup complete"
echo
