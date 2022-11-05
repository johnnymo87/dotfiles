if which direnv > /dev/null; then
  eval "$(direnv hook bash)"
else
  echo "direnv not found!"
fi
