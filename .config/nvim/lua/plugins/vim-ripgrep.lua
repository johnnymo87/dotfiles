-- Runs ripgrep from vim and shows the results in a quickfix window. Better than
-- some fancy neovim knockoffs, which although they can do async jobs, they"re
-- restricted in how they pass arguments to ripgrep, which is a deal breaker.
-- In contrast, this plugin has figured that all out.

return {
  "jremmen/vim-ripgrep",
  cmd = "Rg", -- lazy-load on a command
  keys = {
    -- Map <leader>rr to start an Rg search
    { "<leader>rr", ":Rg ''<left>", desc = "Search with ripgrep" },
  },
}
