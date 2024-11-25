-- On startup, if a session file exists, source it. Otherwise, start recording
-- to one.
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = '*',
    callback = function()
        if vim.fn.filereadable('Session.vim') == 1 then
            print("Sourcing Session.vim")
            vim.cmd('source Session.vim')
        else
            print("Session.vim not found, starting Obsess")
            vim.cmd('Obsess')
        end
    end
})
