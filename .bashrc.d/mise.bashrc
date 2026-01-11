# Initialize mise if it's installed (replaces pyenv, rbenv, nodenv, asdf)
if [ -f "$HOME/.local/bin/mise" ]; then
  eval "$($HOME/.local/bin/mise activate bash)"
elif which mise > /dev/null 2>&1; then
  eval "$(mise activate bash)"
fi
