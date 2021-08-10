# https://waxzce.medium.com/use-bashrc-d-directory-instead-of-bloated-bashrc-50204d5389ff
for file in ~/.bashrc.d/*.bashrc; do
  source "$file"
done
