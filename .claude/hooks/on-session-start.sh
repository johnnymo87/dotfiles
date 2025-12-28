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

# Detect tmux session if running inside tmux
tmux_session=""
if [[ -n "${TMUX:-}" ]]; then
    tmux_session="$(tmux display-message -p '#{session_name}' 2>/dev/null || true)"
fi

# Notify daemon of session start (fire-and-forget)
# Session starts with notify=false; user opts in via /notify command
# Don't fail if daemon isn't running - this is optional
if [[ -n "$session_id" ]]; then
    # Use jq to safely build JSON (handles quotes, newlines, special chars)
    # Convert ppid to number, default to 0 if not numeric
    ppid_num=0
    if [[ "$ppid" =~ ^[0-9]+$ ]]; then
        ppid_num="$ppid"
    fi

    json_payload=$(jq -n \
        --arg session_id "$session_id" \
        --argjson ppid "$ppid_num" \
        --argjson pid "$$" \
        --arg cwd "$PWD" \
        --arg nvim_socket "${NVIM:-}" \
        --arg tmux_session "$tmux_session" \
        '{session_id: $session_id, ppid: $ppid, pid: $pid, cwd: $cwd, nvim_socket: $nvim_socket, tmux_session: $tmux_session}')

    curl -sS --connect-timeout 0.1 --max-time 0.2 \
        -X POST "http://127.0.0.1:3001/session-start" \
        -H "Content-Type: application/json" \
        -d "$json_payload" >/dev/null 2>&1 || true
fi

# No output needed; just succeed
exit 0
