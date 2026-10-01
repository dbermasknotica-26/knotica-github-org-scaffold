#!/usr/bin/env bash
# Usage: ./setup/new-client.sh <CODE> <project> [client-github-username]
# Example: ./setup/new-client.sh NWB core-migration jdoe-northwind
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/config.env"; source "$HERE/lib.sh"
[ $# -ge 2 ] || { echo "Usage: $0 <CODE> <project> [client-github-username]"; exit 1; }
CODE_UP="$(echo "$1" | tr '[:lower:]' '[:upper:]')"; code="$(echo "$1" | tr '[:upper:]' '[:lower:]')"
REPO="cl-${code}-$2"
header "New client workspace: $ORG/$REPO (MODE=$MODE)"
run gh repo create "$ORG/$REPO" --private --template "$ORG/knotica-doc-templates" --description "Client workspace: $CODE_UP $2"
run sleep 5
if is_personal; then
  echo "-- personal mode: skipping team permissions and org Project wiring (they need an organization)"
else
  run gh api -X PUT "orgs/$ORG/teams/delivery/repos/$ORG/$REPO" -f permission=push --silent
  run gh api -X PUT "orgs/$ORG/teams/management/repos/$ORG/$REPO" -f permission=push --silent
  run gh api -X PUT "orgs/$ORG/teams/finance/repos/$ORG/$REPO" -f permission=push --silent
fi
if [ -n "${3:-}" ]; then
  # Organization: triage role. Personal account: collaborators always get write access (no role choice).
  run gh api -X PUT "repos/$ORG/$REPO/collaborators/$3" -f permission=triage --silent
fi
if ! is_personal; then
  PROJ_JSON="$(project_urls_json knotica-doc-templates)"
  if [ -n "$PROJ_JSON" ]; then
    run gh variable set PROJECT_URLS --body "$PROJ_JSON" --repo "$ORG/$REPO"
  fi
fi
"$HERE/04-labels.sh" "$REPO"
run gh label create "client:$CODE_UP" --color "0366d6" --description "Client $CODE_UP" --force --repo "$ORG/sales"
run gh label create "client:$CODE_UP" --color "0366d6" --description "Client $CODE_UP" --force --repo "$ORG/account-management"
run gh label create "client:$CODE_UP" --color "0366d6" --description "Client $CODE_UP" --force --repo "$ORG/finance-accounting"
"$HERE/05-protect-main.sh" "$REPO"
cat <<EOM

Manual follow-ups:
  1. Register client code $CODE_UP in handbook/standards (never reuse codes).
  2. Copy account-management/_template to account-management/$CODE_UP/
  3. Add the signed SOW and contacts to $REPO/00-engagement/
  4. Add the agreed billing schedule to $REPO/07-billing/billing-schedule.md
  5. Add $CODE_UP to the Clients sheet of finance-accounting/registers/Knotica_Billing_Register.xlsx
     (payment terms, currency, whether a PO is required, tax/withholding notes)
  6. Add $REPO to the 'Delivery Portfolio' project (Client field = $CODE_UP)   [organization only]
  7. Open the first spec in $REPO/01-specs/ from SPEC-TEMPLATE.md
EOM
