# Use mise instead - keeping this file for backwards compatibility
if which ~/.rbenv/bin/rbenv > /dev/null 2>&1; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
elif which rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
fi
