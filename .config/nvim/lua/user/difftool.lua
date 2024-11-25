-- Define a module table
local M = {}

-- Define a setup function
M.setup = function()
  -- Use vim.cmd to execute Vimscript commands
  -- Set the diffopt option to control the behavior of diff mode
  -- Add the patience algorithm for better diff calculation
  vim.cmd([[
    let &diffopt="vertical,filler,internal,context:4"
    let &diffopt=&diffopt . ",algorithm:patience"
  ]])

  -- Set the difftool command to use nvim -d for opening files in diff mode
  vim.g.difftool_cmd = "nvim -d -p \"$LOCAL\" \"$REMOTE\""

  -- Create a new autocommand group named "vimrc_difftool"
  -- The { clear = true } option ensures that any existing autocommands in this group are cleared
  vim.api.nvim_create_augroup("vimrc_difftool", { clear = true })

  -- Create a new autocommand that runs when Neovim is entered (VimEnter event)
  vim.api.nvim_create_autocmd("VimEnter", {
    -- Associate the autocommand with the "vimrc_difftool" group
    group = "vimrc_difftool",
    -- Define a callback function that will be executed when the autocommand is triggered
    callback = function()
      -- Check if the diff option is set (which happens when opening files in diff mode)
      if vim.o.diff then
        -- If the diff option is set, run the :diffthis command in each window
        -- This enables diff mode and highlights the differences between the buffers
        vim.cmd("windo diffthis")
      end
    end,
  })
end

-- Return the module table
return M
