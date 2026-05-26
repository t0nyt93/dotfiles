#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

mkdir -p "$HOME/.config"

link() {
    local src="$1"
    local dst="$2"

    if [ -L "$dst" ]; then
        rm "$dst"
    fi

    ln -sf "$src" "$dst"
}

link "$DOTFILES/nvim" "$HOME/.config/nvim"
link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo "Done"
