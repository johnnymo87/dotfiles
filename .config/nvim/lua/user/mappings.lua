-- Change leader to a comma because the backslash is too far away.
vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- Simplify getting back to Normal mode after entering Terminal in Insert mode.
-- Map it to Ctrl-w a, which isn"t mapped to anything by default.
vim.api.nvim_set_keymap("t", "<C-W>a", "<C-\\><C-n>", {noremap = true})

-- Strip trailing whitespaces.
vim.api.nvim_set_keymap("n", "<leader>s", ":%s/\\s\\+$//e<CR>", {noremap = true})

-- Copy current file"s path to system buffer.
vim.api.nvim_set_keymap("n", "<leader>cp", ":let @+=@%<CR>", {noremap = true})

-- Jump-start a vim-ripgrep search.
vim.api.nvim_set_keymap("n", "<leader>rr", ":Rg ''<left>", {noremap = true})

-- Jump-start a :Git (Fugitive) command.
vim.api.nvim_set_keymap("n", "<leader>gg", ":Git ", {noremap = true})

-- Make normal mode shift-k do nothing rather than trying to open help for the
-- word under the cursor.
-- map('n', '<S-k>', '<Nop>')
