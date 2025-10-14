-- Keymaps for the 'aichat' filetype.
-- These mappings are buffer-local and only active in .aichat files.

local aichat_helpers = require('user.aichat')

vim.keymap.set('n', '<leader>a', aichat_helpers.apply_file, { desc = "AI: Apply file change", buffer = true })
vim.keymap.set('n', '<leader>r', aichat_helpers.read_file, { desc = "AI: Read file into buffer", buffer = true })
vim.keymap.set('n', '<leader>c', aichat_helpers.clean_azure_files, { desc = "AI: Clean Azure file block", buffer = true })
