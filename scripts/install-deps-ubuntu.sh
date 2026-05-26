#!/usr/bin/env bash

set -euo pipefail

sudo apt update

# Install our common missing libraries on a vanilla WSL install.
sudo apt install -y \
    git \
    curl \
    unzip \
    build-essential \
    ripgrep \
    fd-find \
    python3 \
    python3-pip \
    npm

# Map fd-find to fthed
sudo ln -sf "$(which fdfind)" /usr/local/bin/fd
