#!/bin/bash
set -uo pipefail

notes_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zed-agent-notes"
notes_file="$notes_dir/notes.jsonl"
mkdir -p "$notes_dir"

file="${ZED_FILE:-}"
if [ -z "$file" ]; then
  echo "No file context - run this from an editor buffer." >&2
  exit 1
fi

worktree="${ZED_WORKTREE_ROOT:-$PWD}"
relative="${ZED_RELATIVE_FILE:-$file}"
row="${ZED_ROW:-0}"
symbol="${ZED_SYMBOL:-}"
selection="${ZED_SELECTED_TEXT:-}"

if [ -z "$selection" ] && [ -r "$file" ]; then
  selection="$(sed -n "${row}p" "$file")"
fi

printf '\033[1m%s:%s\033[0m\n' "$relative" "$row"
if [ -n "$selection" ]; then
  printf '\033[2m%s\033[0m\n' "$selection"
fi

printf 'note> '
IFS= read -r comment || comment=""

if [ -z "$comment" ]; then
  echo "Cancelled - nothing saved."
  exit 0
fi

jq -nc \
  --arg created "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  --arg worktree "$worktree" \
  --arg file "$relative" \
  --arg row "$row" \
  --arg symbol "$symbol" \
  --arg selection "$selection" \
  --arg comment "$comment" \
  '{created: $created, worktree: $worktree, file: $file, row: ($row | tonumber? // 0), symbol: $symbol, selection: $selection, comment: $comment, status: "pending"}' \
  >> "$notes_file" || { echo "Failed to write note." >&2; exit 1; }

pending="$(grep -c '"status":"pending"' "$notes_file")"
echo "Saved. $pending pending."
