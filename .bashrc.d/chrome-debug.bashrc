# Chrome with CDP enabled for remote browser development
# See: ~/.claude/skills/remote-browser-development/SKILL.md

# Ephemeral profile (clean slate each time)
alias chrome-debug='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222 --user-data-dir=/tmp/chrome-debug'

# Persistent profile (keeps logins, cookies between sessions)
alias chrome-debug-persist='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222 --user-data-dir=~/.chrome-debug'

# Quick check if CDP is responding
alias cdp-check='curl -s http://localhost:9222/json/version | head -5'
