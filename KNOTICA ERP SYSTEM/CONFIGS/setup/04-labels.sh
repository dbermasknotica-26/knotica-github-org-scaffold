#!/usr/bin/env bash
# Usage: 04-labels.sh [repo]   (no argument = all repos in repos.txt)
# labels.txt goes to every repo. labels-finance-accounting.txt is added only to
# the 'finance-accounting' repo.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/config.env"; source "$HERE/lib.sh"
header "Syncing labels"
sync_file() {   # sync_file <labels-file> <repo>
  while IFS='|' read -r n c d; do
    [[ -z "${n:-}" || "$n" == \#* ]] && continue
    run gh label create "$n" --color "$c" --description "$d" --force --repo "$ORG/$2"
  done < "$1"
}
sync() {
  sync_file "$HERE/labels.txt" "$1"
  if [ "$1" = "finance-accounting" ] && [ -f "$HERE/labels-finance-accounting.txt" ]; then
    sync_file "$HERE/labels-finance-accounting.txt" "$1"
  fi
}
if [ -n "${1:-}" ]; then sync "$1"; else
  while IFS='|' read -r name _; do
    [[ -z "${name:-}" || "$name" == \#* || "$name" == ".github" ]] && continue
    echo "-- $name"; sync "$name"
  done < "$HERE/repos.txt"
fi
