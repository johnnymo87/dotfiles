-- Load my settings and mappings
require("user.settings")
require("user.mappings")

-- Plugins managed by lazy.nvim.
require("config.lazy")

-- Load settings that should only be applied after plugins are loaded.
require("user.post_plugins")

-- Load configuration for plugins.
require("user.cursor_highlight")
-- require("user.difftool").setup()
require("user.telescope")
-- require("user.vim-obsession")
-- require("user.tree-sitter")
