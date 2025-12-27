-- Load my settings and mappings
require("user.settings")
require("user.mappings")

-- Plugins managed by lazy.nvim.
require("config.lazy")

-- Load configuration for plugins.
require("user.atlassian")
require("user.cursor_highlight")
-- require("user.difftool").setup()
require("user.telescope")
-- require("user.vim-obsession")
-- require("user.tree-sitter")

-- Claude Code Remote control via RPC
require("ccremote").setup()
