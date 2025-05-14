# From https://asdf-vm.com/guide/getting-started.html

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

if which asdf > /dev/null; then
  . <(asdf completion bash)
else
  echo "asdf not found!"
fi
