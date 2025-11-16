-- mini.align - Align text interactively
-- Part of mini.nvim suite, provides interactive text alignment with live preview
-- Default mappings: ga (start), gA (start with preview)

return {
  "echasnovski/mini.align",
  version = false,
  config = function()
    require("mini.align").setup()
  end,
}
