# Initialize starship if it's installed.
if which starship > /dev/null 2>&1; then
  eval "$(starship init bash)"
fi
