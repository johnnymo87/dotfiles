#!/usr/bin/env bash
set -euo pipefail
input="$(cat)"
ppid="${PPID:-unknown}"
dir="${HOME}/.claude/runtime/${ppid}"
mkdir -p "$dir"

transcript_path="$(printf '%s' "$input" | jq -r '.transcript_path // empty')"
session_id="$(printf '%s' "$input" | jq -r '.session_id // empty')"

# Write both for debugging; statusline will read transcript_path
printf '%s\n' "$transcript_path" > "${dir}/transcript_path"
printf '%s\n' "$session_id"      > "${dir}/session_id"

# No output needed; just succeed
exit 0
