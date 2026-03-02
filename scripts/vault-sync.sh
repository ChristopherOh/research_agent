#!/usr/bin/env bash
set -euo pipefail

VAULT_DIR="${VAULT_DIR:-/home/ubuntu/vault}"
BRANCH="${VAULT_BRANCH:-main}"

cd "$VAULT_DIR"

git add -A
if git diff --cached --quiet; then
  exit 0
fi

git commit -m "auto: $(date +%Y-%m-%d-%H%M) research update"
git push origin "$BRANCH"
