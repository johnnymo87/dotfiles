# Use mise instead - keeping this file for backwards compatibility
if which ~/.pyenv/bin/pyenv > /dev/null 2>&1; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  export PYENV_ROOT="$HOME/.pyenv"
  eval "$(pyenv init -)"
elif which pyenv > /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
