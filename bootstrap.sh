#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Dotfiles Bootstrap ==="
echo

"${ROOT_DIR}/scripts/validate.sh"
"${ROOT_DIR}/scripts/link.sh"
"${ROOT_DIR}/scripts/bootstrap-nvim.sh"

echo
echo "[+] Bootstrap complete"
