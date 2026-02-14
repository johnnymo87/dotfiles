#!/bin/bash
# Verify dotfiles symlinks are in place and working
# Run this to detect drift; run install.sh to fix issues

set -euo pipefail

errors=0
warnings=0

# Check if symlink exists and is valid (doesn't care which dotfiles clone)
check_symlink() {
  local target="$1"
  local description="$2"

  if [ ! -L "$target" ] && [ ! -e "$target" ]; then
    echo "MISSING: $description"
    echo "         $target does not exist"
    ((errors++)) || true
  elif [ -L "$target" ]; then
    if [ ! -e "$target" ]; then
      echo "BROKEN:  $description"
      echo "         $target is a broken symlink"
      ((errors++)) || true
    fi
    # Symlink exists and is valid - good enough
  elif [ -e "$target" ]; then
    echo "NOT SYMLINK: $description"
    echo "         $target exists but is not a symlink"
    ((errors++)) || true
  fi
}

# For files that might be managed by home-manager instead
check_symlink_or_hm() {
  local target="$1"
  local description="$2"

  if [ ! -L "$target" ] && [ ! -e "$target" ]; then
    echo "MISSING: $description"
    echo "         $target does not exist"
    ((errors++)) || true
  elif [ -L "$target" ]; then
    if [ ! -e "$target" ]; then
      echo "BROKEN:  $description"
      echo "         $target is a broken symlink"
      ((errors++)) || true
    fi
    # Symlink exists and is valid - could be dotfiles or home-manager
  elif [ -e "$target" ]; then
    # File exists but is not a symlink - might be home-manager managed (mutable file)
    echo "INFO:    $description is a regular file (possibly home-manager managed)"
    ((warnings++)) || true
  fi
}

echo "Checking dotfiles symlinks..."
echo ""

# Shell
check_symlink "$HOME/.bashrc" ".bashrc"
check_symlink "$HOME/.bashrc.d" ".bashrc.d"
check_symlink "$HOME/.bash_profile" ".bash_profile"

# Git
check_symlink "$HOME/.gitconfig" ".gitconfig"
check_symlink "$HOME/.gitignore_global" ".gitignore_global"

# Vim
check_symlink "$HOME/.vimrc" ".vimrc"

# Neovim - top level files
check_symlink "$HOME/.config/nvim/init.lua" "nvim/init.lua"
check_symlink "$HOME/.config/nvim/lazy-lock.json" "nvim/lazy-lock.json"

# Neovim - top level directories
check_symlink "$HOME/.config/nvim/autoload" "nvim/autoload"
check_symlink "$HOME/.config/nvim/ftplugin" "nvim/ftplugin"

# Neovim - lua subdirectories
check_symlink "$HOME/.config/nvim/lua/config" "nvim/lua/config"
check_symlink "$HOME/.config/nvim/lua/plugins" "nvim/lua/plugins"
check_symlink "$HOME/.config/nvim/lua/user" "nvim/lua/user"

# Neovim - lua top-level files (ccremote.lua, etc.)
# These might be home-manager managed on some systems
for f in "$HOME/.config/nvim/lua/"*.lua; do
  [ -e "$f" ] || continue
  fname=$(basename "$f")
  check_symlink_or_hm "$f" "nvim/lua/$fname"
done

# Tmux
check_symlink "$HOME/.tmux.conf" ".tmux.conf"
check_symlink "$HOME/.tmux" ".tmux"

# Claude Code (settings.json may be home-manager managed)
check_symlink_or_hm "$HOME/.claude/settings.json" ".claude/settings.json"
check_symlink_or_hm "$HOME/.claude/hooks" ".claude/hooks"

# Claude skills - check expected ones exist (some may be home-manager managed)
expected_skills=(
  "configuring-neovim"
  "creating-ephemeral-k8s-exec-pods"
  "fixing-tmux-socket-issues"
  "managing-stacked-prs"
  "querying-web-search-agent"
  "using-github-api-with-gh"
)
for skill in "${expected_skills[@]}"; do
  check_symlink_or_hm "$HOME/.claude/skills/$skill" ".claude/skills/$skill"
done

# Claude commands - check expected ones exist
# (Currently none in dotfiles, all migrated to workstation or private)

echo ""
if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
  echo "All symlinks OK"
  exit 0
elif [ $errors -eq 0 ]; then
  echo "All symlinks OK ($warnings info message(s))"
  exit 0
else
  echo "Found $errors error(s). Run install.sh to fix."
  [ $warnings -gt 0 ] && echo "Also: $warnings info message(s) (likely home-manager managed)"
  exit 1
fi
