---
description: Enable Telegram notifications for this Claude Code session
allowed-tools: [Bash, Read, Glob]
---

Enable Telegram notifications for this session so you'll be alerted when tasks complete.

**Label:** $ARGUMENTS

**Steps to register:**

1. **Find the current session ID** using ppid-map:
   ```bash
   # List ppid-map entries by modification time (newest first)
   ls -lt ~/.claude/runtime/ppid-map/ | head -5
   ```

   Choose the most recent entry that was created when this session started.
   Read it to get the session_id:
   ```bash
   cat ~/.claude/runtime/ppid-map/<PPID>
   ```

   **Verify** it's the right session by checking the transcript path exists:
   ```bash
   cat ~/.claude/runtime/sessions/<SESSION_ID>/transcript_path
   ```

2. **Register with the daemon:**
   ```bash
   curl -s -X POST "http://localhost:3001/sessions/enable-notify" \
       -H "Content-Type: application/json" \
       -d '{"session_id": "<SESSION_ID>", "label": "<LABEL>", "nvim_socket": ""}'
   ```

3. **Write notify_label** to session directory (hooks read from here):
   ```bash
   mkdir -p ~/.claude/runtime/sessions/<SESSION_ID>
   echo "<LABEL>" > ~/.claude/runtime/sessions/<SESSION_ID>/notify_label
   ```

**Label to use:** "$ARGUMENTS" (or current directory basename if empty)

After registering, confirm to the user:
- Whether registration succeeded
- The session ID and label used
- That they'll receive Telegram notifications when tasks complete
