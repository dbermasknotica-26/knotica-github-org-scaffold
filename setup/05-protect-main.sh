#!/usr/bin/env bash
# Usage: 05-protect-main.sh [repo]. Requires pull request + 1 approval + code owner review on main.
# Note: branch protection on PRIVATE repos requires a paid GitHub plan.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/config.env"; source "$HERE/lib.sh"
skip_if_personal "branch protection (a sole account owner could not merge their own PRs once 1 approval is required)"
header "Protecting main branches"
protect() {
  run gh api -X PUT "repos/$ORG/$1/branches/main/protection" --input "$HERE/protection.json" --silent \
    || echo "   could not protect $1 (check plan / permissions)"
}
if [ -n "${1:-}" ]; then protect "$1"; else
  while IFS='|' read -r name _; do
    [[ -z "${name:-}" || "$name" == \#* ]] && continue
    protect "$name"
  done < "$HERE/repos.txt"
fi
