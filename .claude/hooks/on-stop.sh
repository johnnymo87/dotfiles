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
if [[ -f "${dir}/notify_label" ]]; then
    : # opted in, continue
else
    # Not opted in, skip notification
    exit 0
fi

label=$(cat "${dir}/notify_label")

# Get transcript path from hook input
transcript_path=$(printf '%s' "$input" | jq -r '.transcript_path // empty' 2>/dev/null || true)

# Extract Claude's last assistant message with text content from transcript JSONL
last_message=""
if [[ -n "$transcript_path" && -f "$transcript_path" ]]; then
    # Use jq to find the last assistant message that has text content
    # tac reverses the file, jq filters for assistant messages with text, head -1 gets first match
    last_message=$(tac "$transcript_path" 2>/dev/null \
        | jq -r 'select(.type=="assistant") | .message.content[]? | select(.type=="text") | .text' 2>/dev/null \
        | head -c 4000 \
        || true)
fi

# Fallback if no message found
if [[ -z "$last_message" ]]; then
    last_message="Task completed"
fi

# Send stop event to daemon (fire-and-forget)
# Use a temp file for the JSON to handle special characters properly
json_payload=$(jq -n \
    --arg session_id "$session_id" \
    --arg label "$label" \
    --arg event "Stop" \
    --arg message "$last_message" \
    '{session_id: $session_id, label: $label, event: $event, message: $message}')

curl -s -X POST "http://localhost:3001/stop" \
    -H "Content-Type: application/json" \
    -d "$json_payload" >/dev/null 2>&1 || true

exit 0
