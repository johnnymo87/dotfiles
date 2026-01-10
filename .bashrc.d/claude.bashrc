# Add Claude Code to PATH
export PATH="$HOME/.local/bin:$PATH"

# Claude Code Remote: Start neovim with RPC socket for remote control
# Usage: nvims [files...]
# The socket allows external tools to send commands to Claude instances
# running in neovim terminal buffers.
# Each instance gets a unique socket. Inside terminals, $NVIM is auto-set by nvim.
nvims() {
    local socket="/tmp/nvim-${RANDOM}-$$.sock"
    nvim --listen "$socket" "$@"
}
