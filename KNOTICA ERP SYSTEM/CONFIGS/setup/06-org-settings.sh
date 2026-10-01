#!/usr/bin/env bash
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/config.env"; source "$HERE/lib.sh"
skip_if_personal "organization settings"
header "Org settings: no default repo access, members cannot create repos"
run gh api -X PATCH "orgs/$ORG" -f default_repository_permission=none -F members_can_create_repositories=false --silent \
  || echo "   could not update org settings (need org owner + admin:org scope)"
echo "Reminder: require two-factor authentication in Org Settings > Authentication security (web UI only)."
