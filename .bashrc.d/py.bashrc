if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
else
  echo "pyenv not found!"
fi
