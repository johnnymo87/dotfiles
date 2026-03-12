-- Load my settings and mappings
require("user.settings")
require("user.mappings")

-- Plugins managed by lazy.nvim.
require("config.lazy")

-- Load configuration for plugins.
require("user.atlassian")
require("user.cursor_highlight")
-- require("user.difftool").setup()
require("user.tabby")       -- OpenCode session titles in tab labels (HM-deployed)
require("user.telescope")
-- require("user.tree-sitter")

-- Autocommand for custom filetypes
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.aichat",
  callback = function()
    vim.bo.filetype = "aichat"
  end,
})

