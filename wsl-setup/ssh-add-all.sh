#!/usr/bin/env bash
set -e

SSH_DIR="$HOME/.ssh"

[ -d "$SSH_DIR" ] || exit 0

for key in "$SSH_DIR"/*; do
  [ -f "$key" ] || continue

  case "$key" in
    *.pub|*known_hosts|*config)
      continue
      ;;
  esac

  ssh-add "$key" >/dev/null 2>&1 || true
done
