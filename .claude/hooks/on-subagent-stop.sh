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

# Extract Claude's last assistant message from transcript JSONL
last_message=""
if [[ -n "$transcript_path" && -f "$transcript_path" ]]; then
    # Get the last assistant message's text content
    # Transcript is JSONL with .type="assistant" and .message.content[].text
    last_message=$(tac "$transcript_path" 2>/dev/null | while read -r line; do
        msg_type=$(printf '%s' "$line" | jq -r '.type // empty' 2>/dev/null)
        if [[ "$msg_type" == "assistant" ]]; then
            # Extract text from content array, join multiple text blocks
            printf '%s' "$line" | jq -r '.message.content[]? | select(.type=="text") | .text' 2>/dev/null | head -c 4000
            break
        fi
    done)
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

curl -s -X POST "http://localhost:3001/stop" \
    -H "Content-Type: application/json" \
    -d "$json_payload" >/dev/null 2>&1 || true

exit 0
