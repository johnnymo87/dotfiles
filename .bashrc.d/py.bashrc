# For the github install of pyenv.
if which ~/.pyenv/bin/pyenv > /dev/null; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  export PYENV_ROOT="$HOME/.pyenv"
fi

if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
else
  echo "pyenv not found!"
fi
