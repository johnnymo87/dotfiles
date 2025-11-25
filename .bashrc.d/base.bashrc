# Increase per-process file descriptor limit to avoid pty exhaustion
ulimit -n 2048

# Use nvim as my default editor (in e.g. git commits, bundle open, etc).
export EDITOR=nvim

# Open nvim:
# * With a login shell so that all env vars are sourced.
# * To a terminal.
function nvimt() {
  # The command string for the shell's -c option needs to be: nvim '+:te'
  # To make the single quotes part of the argument to nvim,
  # it becomes: nvim '\''+:te'\''
  # This whole thing is then wrapped in single quotes for -c:
  env -S "$SHELL -l -c 'nvim '\''+:te'\'''"
}

alias cdc="cd ~/Code"
