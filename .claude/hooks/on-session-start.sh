#!/usr/bin/env bash
set -euo pipefail
input="$(cat)"
ppid="${PPID:-unknown}"

# Extract session info from hook input
transcript_path="$(printf '%s' "$input" | jq -r '.transcript_path // empty')"
session_id="$(printf '%s' "$input" | jq -r '.session_id // empty')"

# Primary storage: by session_id (robust, survives PID reuse)
if [[ -n "$session_id" ]]; then
    session_dir="${HOME}/.claude/runtime/sessions/${session_id}"
    mkdir -p "$session_dir"
    printf '%s\n' "$transcript_path" > "${session_dir}/transcript_path"
    printf '%s\n' "$ppid" > "${session_dir}/ppid"
fi

# Secondary: ppid-map for slash commands that only know PPID
# Maps PPID -> session_id for quick lookup
if [[ -n "$session_id" && "$ppid" =~ ^[0-9]+$ ]]; then
    mkdir -p "${HOME}/.claude/runtime/ppid-map"
    printf '%s\n' "$session_id" > "${HOME}/.claude/runtime/ppid-map/${ppid}"
fi

# Tertiary: pane-map for tmux environments (more reliable than PPID)
# Key format: <socket_name>-<pane_num> to handle multiple tmux servers
# e.g., "default-4" for socket /tmp/tmux-504/default, pane %4
if [[ -n "$session_id" && -n "${TMUX:-}" && -n "${TMUX_PANE:-}" ]]; then
    socket_path="${TMUX%%,*}"
    socket_name=$(basename "$socket_path")
    pane_num="${TMUX_PANE#%}"
    pane_key="${socket_name}-${pane_num}"
    mkdir -p "${HOME}/.claude/runtime/pane-map"
    printf '%s\n' "$session_id" > "${HOME}/.claude/runtime/pane-map/${pane_key}"
fi

# Legacy: keep PPID-based dir for backward compatibility
dir="${HOME}/.claude/runtime/${ppid}"
mkdir -p "$dir"
printf '%s\n' "$transcript_path" > "${dir}/transcript_path"
printf '%s\n' "$session_id"      > "${dir}/session_id"

# Detect tmux session if running inside tmux
# Capture full pane target (session:window.pane) for accurate injection
tmux_session=""
tmux_pane=""
if [[ -n "${TMUX:-}" ]]; then
    tmux_session="$(tmux display-message -p '#{session_name}' 2>/dev/null || true)"
    tmux_pane="$(tmux display-message -p '#{session_name}:#{window_index}.#{pane_index}' 2>/dev/null || true)"
fi

# Notify daemon of session start (fire-and-forget)
# Don't fail if daemon isn't running - this is optional
if [[ -n "$session_id" ]]; then
    # Use jq to safely build JSON (handles quotes, newlines, special chars)
    # Convert ppid to number, default to 0 if not numeric
    ppid_num=0
    if [[ "$ppid" =~ ^[0-9]+$ ]]; then
        ppid_num="$ppid"
    fi

    # Check if notify_label exists from previous opt-in (survives session restarts)
    notify_label=""
    notify_flag="false"
    if [[ -f "${session_dir}/notify_label" ]]; then
        notify_label=$(cat "${session_dir}/notify_label")
        notify_flag="true"
    fi

    json_payload=$(jq -n \
        --arg session_id "$session_id" \
        --argjson ppid "$ppid_num" \
        --argjson pid "$$" \
        --arg cwd "$PWD" \
        --arg nvim_socket "${NVIM:-}" \
        --arg tmux_session "$tmux_session" \
        --arg tmux_pane "$tmux_pane" \
        --argjson notify "$notify_flag" \
        --arg label "$notify_label" \
        '{session_id: $session_id, ppid: $ppid, pid: $pid, cwd: $cwd, nvim_socket: $nvim_socket, tmux_session: $tmux_session, tmux_pane: $tmux_pane, notify: $notify, label: $label}')

    curl -sS --connect-timeout 1 --max-time 2 \
        -X POST "http://127.0.0.1:3001/session-start" \
        -H "Content-Type: application/json" \
        -d "$json_payload" >/dev/null 2>&1 || true
fi

# No output needed; just succeed
exit 0
