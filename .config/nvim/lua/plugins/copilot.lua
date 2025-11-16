-- GitHub Copilot uses OpenAI Codex to suggest code and entire functions in
-- real-time right from your editor. Trained on billions of lines of public
-- code, GitHub Copilot turns natural language prompts including comments and
-- method names into coding suggestions across dozens of languages.

return {
  "github/copilot.vim",
  event = "InsertEnter", -- Lazy-load on entering Insert mode
  init = function()
    -- Disable default Tab mapping to avoid conflict with nvim-cmp
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
  end,
  config = function()
    -- Map Ctrl+J to accept Copilot suggestions
    vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
      silent = true,
    })
  end,
}
