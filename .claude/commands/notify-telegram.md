---
description: Enable Telegram notifications for this Claude Code session
allowed-tools: [Bash, Read]
---

Enable Telegram notifications for this session so you'll be alerted when tasks complete.

**Label:** $ARGUMENTS

**How it works:**
1. Read your session ID from `~/.claude/runtime/$PPID/session_id`
2. Register with the notification daemon at `localhost:3001`
3. When tasks complete, you'll receive Telegram notifications with action buttons

**Execute this registration:**

```bash
#!/bin/bash
set -e

# Get session ID from runtime directory
PPID_DIR="$HOME/.claude/runtime/$PPID"
SESSION_FILE="$PPID_DIR/session_id"

if [[ ! -f "$SESSION_FILE" ]]; then
    echo "Error: Session ID file not found at $SESSION_FILE"
    echo "This may happen if the session just started. Try again in a moment."
    exit 1
fi

SESSION_ID=$(cat "$SESSION_FILE")
LABEL="${1:-$(basename "$PWD")}"
NVIM_SOCK="${NVIM:-}"

echo "Registering session for Telegram notifications..."
echo "  Session ID: $SESSION_ID"
echo "  Label: $LABEL"
if [[ -n "$NVIM_SOCK" ]]; then
    echo "  Neovim socket: $NVIM_SOCK"
fi

# Call daemon to enable notifications
RESPONSE=$(curl -s -X POST "http://localhost:3001/sessions/enable-notify" \
    -H "Content-Type: application/json" \
    -d "{
        \"session_id\": \"$SESSION_ID\",
        \"label\": \"$LABEL\",
        \"nvim_socket\": \"$NVIM_SOCK\"
    }" 2>&1)

if echo "$RESPONSE" | grep -q '"ok":true'; then
    echo ""
    echo "Notifications enabled!"
    echo "You'll receive Telegram alerts when this session completes tasks."

    # Also write the label to runtime dir for the stop hook
    echo "$LABEL" > "$PPID_DIR/notify_label"
else
    echo ""
    echo "Error: Failed to register with daemon"
    echo "Response: $RESPONSE"
    echo ""
    echo "Make sure the webhook server is running:"
    echo "  cd ~/Code/Claude-Code-Remote && npm start"
    exit 1
fi
```

Run the above script with the label "$ARGUMENTS" (or use the current directory name if no label provided).

After running, confirm to the user:
- Whether registration succeeded
- What label was used
- That they'll receive Telegram notifications when tasks complete
