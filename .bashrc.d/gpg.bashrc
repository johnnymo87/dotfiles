#!/usr/bin/env bash

# GPG TTY configuration for tmux compatibility
# Ensures GPG can prompt for passphrases correctly in both tmux and regular terminals

if [ -n "$TMUX" ]; then
    # In tmux: use the pane's TTY instead of the outer session TTY
    export GPG_TTY=$(tmux display-message -p '#{pane_tty}')
else
    # Regular terminal: use the current TTY
    export GPG_TTY=$(tty)
fi
