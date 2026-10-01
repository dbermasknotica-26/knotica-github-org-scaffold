#!/usr/bin/env bash
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/config.env"; source "$HERE/lib.sh"
skip_if_personal "teams"
header "Creating teams in $ORG"
while IFS='|' read -r slug desc; do
  [[ -z "${slug:-}" || "$slug" == \#* ]] && continue
  run gh api -X POST "orgs/$ORG/teams" -f name="$slug" -f description="$desc" -f privacy=closed --silent \
    || echo "   ($slug may already exist)"
done < "$HERE/teams.txt"
