# For the github install of rbenv.
if which ~/.rbenv/bin/rbenv > /dev/null; then
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
else
  echo "rbenv not found!"
fi
