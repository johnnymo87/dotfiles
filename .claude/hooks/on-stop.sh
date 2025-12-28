#!/usr/bin/env bash
set -euo pipefail

# Read hook input from Claude
input="$(cat)"
ppid="${PPID:-unknown}"
dir="${HOME}/.claude/runtime/${ppid}"

# Get session ID
session_id=""
if [[ -f "${dir}/session_id" ]]; then
    session_id=$(cat "${dir}/session_id")
fi

# Exit early if no session tracking
if [[ -z "$session_id" ]]; then
    exit 0
fi

# Check if this session opted into notifications
# The /notify command writes this file
if [[ ! -f "${dir}/notify_label" ]]; then
    # Not opted in, skip notification
    exit 0
fi

label=$(cat "${dir}/notify_label")

# Parse summary from Claude's input (if available)
summary=$(printf '%s' "$input" | jq -r '.summary // "Task completed"' 2>/dev/null || echo "Task completed")

# Send stop event to daemon (fire-and-forget)
curl -s -X POST "http://localhost:3001/stop" \
    -H "Content-Type: application/json" \
    -d "{
        \"session_id\": \"$session_id\",
        \"label\": \"$label\",
        \"event\": \"Stop\",
        \"summary\": \"$summary\"
    }" >/dev/null 2>&1 || true

exit 0
