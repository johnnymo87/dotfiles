# Home-manager integration (bridge until full bash migration)
# Adds HM-managed packages to PATH and provides session variables

# Per-user profile from nix-darwin + home-manager
if [ -d "/etc/profiles/per-user/$USER/bin" ]; then
  export PATH="/etc/profiles/per-user/$USER/bin:$PATH"
fi

# Home-manager session variables (if available)
# Check Darwin path first (nix-darwin), then standalone HM path
if [ -e "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
  . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
elif [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

# Aliases for HM-managed scripts
alias ssdb='screenshot-to-devbox'
