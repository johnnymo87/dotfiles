-- I often lose my cursor on the screen, and I'd like a way to quickly find it.
-- Solution inspired by https://vim.fandom.com/wiki/Highlight_current_line

-- Define a function to toggle cursor line and column highlighting
local function toggle_cursor_highlight()
    -- Get the current state of cursorline and cursorcolumn
    local cursorline = vim.wo.cursorline
    local cursorcolumn = vim.wo.cursorcolumn

    -- Toggle the state
    vim.wo.cursorline = not cursorline
    vim.wo.cursorcolumn = not cursorcolumn

    -- Define the highlight groups with corrected keys
    local highlight_group_settings = {
        CursorLine = { bg = 'DarkRed', fg = 'White' },
        CursorColumn = { bg = 'DarkRed', fg = 'White' }
    }

    -- Apply the highlight settings
    for group, settings in pairs(highlight_group_settings) do
        vim.api.nvim_set_hl(0, group, settings)
    end
end

-- Map <C-K> to toggle cursor highlight
vim.api.nvim_set_keymap('n', '<C-K>', '', { noremap = true, silent = true, callback = toggle_cursor_highlight })
