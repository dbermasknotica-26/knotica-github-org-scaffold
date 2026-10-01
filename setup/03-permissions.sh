#!/usr/bin/env bash
# Grants teams access to repos according to permissions.csv (the access matrix in the design doc).
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/config.env"; source "$HERE/lib.sh"
skip_if_personal "team permissions"
header "Applying team permissions"
while IFS=',' read -r repo team perm; do
  [[ -z "${repo:-}" || "$repo" == \#* ]] && continue
  run gh api -X PUT "orgs/$ORG/teams/$team/repos/$ORG/$repo" -f permission="$perm" --silent \
    || echo "   failed: $team -> $repo"
done < "$HERE/permissions.csv"
