#!/usr/bin/env bash
# Creates every repo in repos.txt from the folders in ../repos and pushes the initial commit.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
source "$HERE/config.env"; source "$HERE/lib.sh"
BUILD="$HERE/../.build"; rm -rf "$BUILD"; mkdir -p "$BUILD"
header "Creating repositories in $ORG (MODE=$MODE)"
while IFS='|' read -r name vis tpl desc; do
  [[ -z "${name:-}" || "$name" == \#* ]] && continue
  echo "-- $ORG/$name ($vis)"
  cp -R "$HERE/../repos/$name" "$BUILD/$name"
  grep -rl "ORG_PLACEHOLDER" "$BUILD/$name" 2>/dev/null | while read -r f; do
    # Personal accounts have no teams: point team mentions (CODEOWNERS, notifications) at the account owner.
    if is_personal; then sed -E -i.bak "s#@ORG_PLACEHOLDER/[A-Za-z0-9_-]+#@$ORG#g" "$f" && rm -f "$f.bak"; fi
    sed -i.bak "s/ORG_PLACEHOLDER/$ORG/g" "$f" && rm -f "$f.bak"
  done || true
  if [ "$DRY_RUN" != "true" ] && gh repo view "$ORG/$name" >/dev/null 2>&1; then
    echo "   already exists, skipping"; continue
  fi
  pushd "$BUILD/$name" >/dev/null
  run git init -q -b main
  run git add -A
  run git -c user.name="$GIT_USER_NAME" -c user.email="$GIT_USER_EMAIL" commit -q -m "chore: initial scaffold"
  run gh repo create "$ORG/$name" "--$vis" --description "$desc" --source . --remote origin --push
  if [ "$tpl" = "yes" ]; then run gh repo edit "$ORG/$name" --template; fi
  popd >/dev/null
done < "$HERE/repos.txt"
