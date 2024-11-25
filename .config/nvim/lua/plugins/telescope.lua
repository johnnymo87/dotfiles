-- A fuzzy finder. It helps me search, filter, find and pick things.
--
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope", -- Lazy-load on the Telescope command
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
  },
  init = function()
    require("user.telescope") -- My telescope configuration
  end,
}
