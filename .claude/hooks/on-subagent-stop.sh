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
if [[ -f "${dir}/notify_label" ]]; then
    : # opted in, continue
else
    exit 0
fi

label=$(cat "${dir}/notify_label")

# Get transcript path from hook input
transcript_path=$(printf '%s' "$input" | jq -r '.transcript_path // empty' 2>/dev/null || true)

# Extract Claude's last assistant message with text content from transcript JSONL
last_message=""
if [[ -n "$transcript_path" && -f "$transcript_path" ]]; then
    # Find the last assistant message that has text content
    # 1. tac reverses the file
    # 2. jq -s slurps all lines into array, finds first (last in original) with text
    # 3. Extract just the text content
    last_message=$(tac "$transcript_path" 2>/dev/null \
        | jq -s '[.[] | select(.type=="assistant") | select(.message.content[]?.type=="text")] | .[0] | .message.content[] | select(.type=="text") | .text' -r 2>/dev/null \
        | head -c 4000 \
        || true)
fi

# Fallback if no message found
if [[ -z "$last_message" ]]; then
    last_message="Subagent completed"
fi

# Send stop event to daemon (fire-and-forget)
# Use jq for proper JSON encoding of the message
json_payload=$(jq -n \
    --arg session_id "$session_id" \
    --arg label "$label" \
    --arg event "SubagentStop" \
    --arg message "$last_message" \
    '{session_id: $session_id, label: $label, event: $event, message: $message}')

curl -sS --connect-timeout 0.1 --max-time 0.2 \
    -X POST "http://127.0.0.1:3001/stop" \
    -H "Content-Type: application/json" \
    -d "$json_payload" >/dev/null 2>&1 || true

exit 0
