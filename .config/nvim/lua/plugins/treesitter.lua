-- A parser generator tool and an incremental parsing library. It can build a
-- concrete syntax tree for a source file and efficiently update the syntax
-- tree as the source file is edited.
-- A plugin that uses treesitter to provide text objects, folding, syntax
-- highlighting, indentation, and more.
-- It uses it to provide a preview of the search results.

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- Run :TSUpdate after installing
  event = { "BufReadPost", "BufNewFile" }, -- Lazy-load on buffer read/new file
  --init = function()
  --  require("user.treesitter") -- My treesitter configuration
  --end,
}
