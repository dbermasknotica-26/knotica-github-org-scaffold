#!/usr/bin/env bash
# PERSONAL TEST MODE ONLY. Deletes the repos this scaffold created in your personal account so you can start over
# (or migrate: delete the test repos, then run the real setup with MODE=org).
#   ./setup/teardown-test.sh                    # dry run: lists what WOULD be deleted
#   DRY_RUN=false ./setup/teardown-test.sh      # asks you to type a confirmation, then deletes
# Only repos named in setup/repos.txt and test client repos named cl-* are touched. Anything else is left alone.
# Needs the delete_repo scope:  gh auth refresh -s delete_repo
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/config.env"; source "$HERE/lib.sh"
is_personal || { echo "Refusing to run: teardown is only for MODE=personal."; exit 1; }
header "Repos that would be deleted from $ORG"
targets=()
while IFS='|' read -r name _; do
  [[ -z "${name:-}" || "$name" == \#* ]] && continue
  targets+=("$name")
done < "$HERE/repos.txt"
if [ "$DRY_RUN" != "true" ]; then
  while read -r r; do targets+=("$r"); done < <(gh repo list "$ORG" --limit 200 --json name -q '.[].name | select(startswith("cl-"))')
fi
for t in "${targets[@]}"; do echo "  $ORG/$t"; done
if [ "$DRY_RUN" = "true" ]; then
  echo; echo "Dry run only. Repos that do not exist are skipped. Re-run with DRY_RUN=false to delete."; exit 0
fi
echo; echo "This permanently deletes the repos above (only those that exist). Your other repos are not touched."
read -r -p "Type DELETE $ORG to continue: " answer
[ "$answer" = "DELETE $ORG" ] || { echo "Cancelled."; exit 1; }
for t in "${targets[@]}"; do
  if gh repo view "$ORG/$t" >/dev/null 2>&1; then
    gh repo delete "$ORG/$t" --yes && echo "deleted $ORG/$t"
  fi
done
