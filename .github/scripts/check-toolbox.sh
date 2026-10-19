#!/usr/bin/env bash
# Checks every GitHub repository linked in the README Toolbox against the bar in
# CONTRIBUTING.md: not archived, a push in the last 180 days, and at least 200 stars.
# Needs the GitHub CLI with a token (GH_TOKEN). Exits 1 if any entry fails.
set -uo pipefail

readme="${1:-README.md}"
min_stars=200
cutoff=$(python3 -c 'import datetime as d; print((d.datetime.now(d.timezone.utc) - d.timedelta(days=180)).strftime("%Y-%m-%d"))')

repos=$(sed -n '/^## Agentic Coding Toolbox/,/^## Contributing/p' "$readme" \
  | grep -oE 'https://github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+' \
  | sed 's|https://github.com/||' \
  | grep -vE '^(features|marketplace|orgs|topics|sponsors)/' \
  | sort -u)

fail=0
report=""
for repo in $repos; do
  if ! info=$(gh api "repos/$repo" --jq '[.archived, .pushed_at[0:10], .stargazers_count] | @tsv' 2>/dev/null); then
    report+="| $repo | not found | | |"$'\n'; fail=1; continue
  fi
  IFS=$'\t' read -r archived pushed stars <<<"$info"
  problems=()
  [ "$archived" = "true" ] && problems+=("archived")
  [[ "$pushed" < "$cutoff" ]] && problems+=("no push since $pushed")
  [ "$stars" -lt "$min_stars" ] && problems+=("$stars stars")
  if [ ${#problems[@]} -gt 0 ]; then
    report+="| $repo | $(IFS=', '; echo "${problems[*]}") | $pushed | $stars |"$'\n'; fail=1
  fi
done

count=$(echo "$repos" | grep -c .)
if [ "$fail" -eq 0 ]; then
  summary="All $count Toolbox repositories pass: not archived, pushed since $cutoff, at least $min_stars stars."
else
  summary=$'Toolbox entries that no longer meet the bar in CONTRIBUTING.md:\n\n| Repository | Problem | Last push | Stars |\n| --- | --- | --- | --- |\n'"$report"
fi
echo "$summary"
[ -n "${GITHUB_STEP_SUMMARY:-}" ] && echo "$summary" >> "$GITHUB_STEP_SUMMARY"
exit "$fail"
