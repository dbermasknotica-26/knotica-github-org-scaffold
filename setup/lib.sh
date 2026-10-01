run() {
  if [ "${DRY_RUN:-true}" = "true" ]; then
    printf '[dry-run] %s\n' "$*"
  else
    "$@"
  fi
}
header() { printf '\n=== %s ===\n' "$*"; }

# MODE helpers. MODE=personal means ORG is a personal GitHub account, not an organization.
is_personal() { [ "${MODE:-org}" = "personal" ]; }
# Call at the top of a script that only works in an organization.
skip_if_personal() {
  if is_personal; then
    echo "-- skipped in MODE=personal: $1 (needs a GitHub organization)"
    exit 0
  fi
}

# Prints a JSON array of project URLs for a repo, from projects.txt (repo|n1,n2). Prints nothing if the repo is not listed.
project_urls_json() {
  local repo="$1" nums out="" n
  local -a arr
  nums="$(grep "^${repo}|" "$HERE/projects.txt" | head -1 | cut -d'|' -f2 || true)"
  [ -z "$nums" ] && return 0
  IFS=',' read -ra arr <<< "$nums"
  for n in "${arr[@]}"; do out+="${out:+,}\"https://github.com/orgs/$ORG/projects/$n\""; done
  printf '[%s]' "$out"
}
