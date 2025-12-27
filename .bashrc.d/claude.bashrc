# Add Claude Code to PATH
export PATH="$HOME/.local/bin:$PATH"

# Claude Code Remote: Start neovim with RPC socket for remote control
# Usage: nvimt [files...]
# The socket allows external tools to send commands to Claude instances
# running in neovim terminal buffers.
alias nvimt='nvim --listen /tmp/nvim-claude.sock'

# Environment variable for nvim socket path (used by Claude-Code-Remote)
export NVIM_SOCKET="/tmp/nvim-claude.sock"
