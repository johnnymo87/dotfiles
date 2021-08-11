# If on a mac ...
if [ "$(uname)" == "Darwin" ]; then
  # If exists, set homebrew in PATH
  if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi
