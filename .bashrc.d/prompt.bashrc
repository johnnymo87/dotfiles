# Initialize starship if it's installed.
if which starship > /dev/null; then
  eval "$(starship init bash)"
else
  echo "Starship not found!"
fi
