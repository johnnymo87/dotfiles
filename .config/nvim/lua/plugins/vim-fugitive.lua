-- Fugitive is the premier Vim plugin for Git. Or maybe it's the premier Git
-- plugin for Vim? Either way, it's "so awesome, it should be illegal". That's
-- why it's called Fugitive.

return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G" },
  keys = {
    -- Map <leader>gg to start a Git command
    { "<leader>gg", ":Git ", desc = "Git command", mode = "n" },
  },
}
