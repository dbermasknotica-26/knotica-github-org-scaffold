#!/usr/bin/env bash
# Runs every step in order. Default is DRY RUN (prints commands only).
#   ./setup/setup.sh                     # preview (MODE from config.env, default "personal")
#   DRY_RUN=false ./setup/setup.sh       # apply for real
#   MODE=org DRY_RUN=false ./setup/setup.sh   # full organization setup
# In MODE=personal the organization-only steps print "skipped" and change nothing.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/config.env"; source "$HERE/lib.sh"
case "$MODE" in personal|org) ;; *) echo "MODE must be 'personal' or 'org' (got '$MODE')"; exit 1 ;; esac
echo "Account: $ORG   MODE=$MODE   DRY_RUN=$DRY_RUN"
if [ "$DRY_RUN" != "true" ] && [[ "$GIT_USER_EMAIL" == CHANGE-ME* ]]; then echo "Set GIT_USER_EMAIL in setup/config.env first."; exit 1; fi
if [ "$DRY_RUN" != "true" ]; then
  command -v gh >/dev/null || { echo "Install GitHub CLI first: https://cli.github.com"; exit 1; }
  if is_personal; then
    gh auth status >/dev/null || { echo "Run: gh auth login (scope: repo, workflow)"; exit 1; }
    me="$(gh api user -q .login)"
    [ "$me" = "$ORG" ] || { echo "You are signed in as '$me' but ORG is '$ORG'. Fix config.env or run: gh auth login"; exit 1; }
  else
    gh auth status >/dev/null || { echo "Run: gh auth login (scopes: repo, admin:org, workflow)"; exit 1; }
    gh api "orgs/$ORG" >/dev/null 2>&1 || { echo "Organization '$ORG' not found or no access. Create it first, or set MODE=personal."; exit 1; }
  fi
fi
for s in 06-org-settings 02-create-teams 01-create-repos 03-permissions 04-labels 05-protect-main; do
  "$HERE/$s.sh"
done
echo
if is_personal; then
  echo "Done (personal test mode). Open https://github.com/$ORG?tab=repositories and try the issue forms. See README.md > 'Test in a personal account first'."
else
  echo "Done. See README.md for the manual steps (members, Projects, 2FA)."
fi
