#!/bin/bash
set -euo pipefail

# Dotfiles install script for fresh Linux dev boxes
# Run with: curl -fsSL <raw-url> | bash
# Or: ./install.sh

DOTFILES_REPO="https://github.com/johnnymo87/dotfiles.git"
DOTFILES_DIR="$HOME/projects/dotfiles"

echo "==> Installing dotfiles..."

# Create projects directory
mkdir -p "$HOME/projects"

# Clone dotfiles if not already present
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "==> Cloning dotfiles..."
  git clone --recurse-submodules "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "==> Dotfiles already cloned, pulling latest..."
  cd "$DOTFILES_DIR" && git pull && git submodule update --init --recursive
fi

# Backup existing configs
echo "==> Backing up existing configs..."
mkdir -p "$HOME/.config-backup"
for f in .bashrc .bash_profile .gitconfig .gitignore_global .vimrc .tmux.conf; do
  [ -f "$HOME/$f" ] && [ ! -L "$HOME/$f" ] && cp "$HOME/$f" "$HOME/.config-backup/${f}.bak" || true
done

# Create symlinks
echo "==> Creating symlinks..."

# Shell
ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/.bashrc.d" "$HOME/.bashrc.d"
ln -sf "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"

# Git
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"

# Vim/Neovim
ln -sf "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.config"

# Create nvim as a real directory with child symlinks
# This allows home-manager to manage additional files (e.g., lua/ccremote.lua)
NVIM_HOME="$HOME/.config/nvim"
NVIM_SRC="$DOTFILES_DIR/.config/nvim"

# Remove old monolithic symlink if it exists
if [ -L "$NVIM_HOME" ]; then
  rm "$NVIM_HOME"
fi
mkdir -p "$NVIM_HOME"

# Symlink top-level files
for f in init.lua lazy-lock.json; do
  [ -f "$NVIM_SRC/$f" ] && ln -sf "$NVIM_SRC/$f" "$NVIM_HOME/$f"
done

# Symlink top-level directories (except lua/)
for d in autoload ftplugin; do
  [ -d "$NVIM_SRC/$d" ] && ln -sfn "$NVIM_SRC/$d" "$NVIM_HOME/$d"
done

# Create lua/ as real directory with child symlinks
mkdir -p "$NVIM_HOME/lua"

# Symlink lua/ subdirectories
for d in config plugins user; do
  [ -d "$NVIM_SRC/lua/$d" ] && ln -sfn "$NVIM_SRC/lua/$d" "$NVIM_HOME/lua/$d"
done

# Symlink top-level lua files (ccremote.lua, etc.)
# On Nix machines, home-manager will replace this with its managed version
for f in "$NVIM_SRC/lua/"*.lua; do
  [ -f "$f" ] && ln -sf "$f" "$NVIM_HOME/lua/$(basename "$f")"
done

# Tmux
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/.tmux" "$HOME/.tmux"

# Claude Code
mkdir -p "$HOME/.claude"
ln -sf "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
rm -rf "$HOME/.claude/hooks" 2>/dev/null || true
ln -sf "$DOTFILES_DIR/.claude/hooks" "$HOME/.claude/hooks"
ln -sf "$DOTFILES_DIR/.claude/statusline.sh" "$HOME/.claude/statusline.sh"

# Claude skills (symlink each to allow private skills)
mkdir -p "$HOME/.claude/skills"
for skill in "$DOTFILES_DIR/.claude/skills/"*/; do
  skill_name=$(basename "$skill")
  ln -sf "$skill" "$HOME/.claude/skills/$skill_name"
done

# Claude commands
mkdir -p "$HOME/.claude/commands"
for cmd in "$DOTFILES_DIR/.claude/commands/"*; do
  cmd_name=$(basename "$cmd")
  ln -sf "$cmd" "$HOME/.claude/commands/$cmd_name"
done

# Install mise (polyglot version manager)
echo "==> Installing mise..."
if [ ! -f "$HOME/.local/bin/mise" ]; then
  curl -fsSL https://mise.run -o /tmp/mise-install.sh
  sh /tmp/mise-install.sh
  rm /tmp/mise-install.sh
else
  echo "    mise already installed"
fi

# Setup gh credential helper if gh is available
if command -v gh &> /dev/null; then
  echo "==> Configuring gh credential helper..."
  gh auth setup-git 2>/dev/null || echo "    (run 'gh auth login' first if not authenticated)"
fi

echo ""
echo "==> Done! Restart your shell or run: source ~/.bashrc"
echo ""
echo "Next steps:"
echo "  1. Run 'gh auth login' to authenticate with GitHub"
echo "  2. Run 'gh ssh-key add ~/.ssh/id_ed25519.pub -t devbox-signing --type signing' to enable commit signing"
echo "  3. Run 'gh auth setup-git' to configure git credential helper"
echo "  4. Run 'mise use python@3.x' to install Python (or other runtimes)"
echo "  5. Open nvim to let lazy.nvim install plugins"
echo ""
if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
  echo "Your SSH public key (for GitHub):"
  cat "$HOME/.ssh/id_ed25519.pub"
fi
