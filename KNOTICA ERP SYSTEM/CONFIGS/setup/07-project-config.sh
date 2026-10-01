#!/usr/bin/env bash
# Run AFTER you created the org Projects (see README). Sets:
#   - org secret PROJECT_TOKEN (from env PROJECT_TOKEN_VALUE; a token with 'project' + 'repo' scope)
#   - repo variable PROJECT_URLS on each repo listed in projects.txt
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/config.env"; source "$HERE/lib.sh"
skip_if_personal "org Project automation config"
header "Project automation config"
if [ -n "${PROJECT_TOKEN_VALUE:-}" ]; then
  if [ "$DRY_RUN" = "true" ]; then
    echo "[dry-run] gh secret set PROJECT_TOKEN --org $ORG --visibility private --body <hidden>"
  else
    gh secret set PROJECT_TOKEN --org "$ORG" --visibility private --body "$PROJECT_TOKEN_VALUE"
  fi
else
  echo "   PROJECT_TOKEN_VALUE is not set: skipping the secret. Export it and re-run to set it."
fi
while IFS='|' read -r repo nums; do
  [[ -z "${repo:-}" || "$repo" == \#* ]] && continue
  json="$(project_urls_json "$repo")"
  echo "-- $repo -> $json"
  run gh variable set PROJECT_URLS --body "$json" --repo "$ORG/$repo"
done < "$HERE/projects.txt"
