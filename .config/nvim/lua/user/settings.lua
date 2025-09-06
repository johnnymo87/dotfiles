-- Make `,` my leader key.
vim.g.mapleader = ','

-- Display tabs and trailing spaces visually.
vim.opt.list = true
vim.opt.listchars = "tab:▷▷⋮,trail:·"

-- Tree-sitter based folding.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- Don't wrap lines by default.
vim.opt.wrap = false

-- Show line numbers.
vim.opt.number = true
-- Show relative line numbers.
vim.opt.relativenumber = true

-- Enable true color support.
vim.opt.termguicolors = true

-- A visual guide for my column soft and hard limits.
vim.cmd("highlight ColorColumn ctermbg=235 guibg=#2c2d27")
vim.opt.colorcolumn = "80,121"

-- Use system clipboard by default.
vim.opt.clipboard = "unnamed,unnamedplus"

-- Search options.
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Configure netrw, the built-in file explorer.
vim.g.netrw_keepj = ""

-- Turn Off Swap Files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Disallow switching buffers without either saving or discarding changes
-- first.
vim.opt.hidden = false

-- Default indentation settings.
--
-- Turn tabs into spaces.
vim.opt.expandtab = true
--
-- Copy the structure of the existing lines indent when autoindenting a new
-- line.
vim.opt.copyindent = true
--
-- When changing the indent of the current line, preserve as much of the indent
-- structure as possible.
vim.opt.preserveindent = true
--
-- Set how many columns of whitespace a level of indentation is worth.
vim.opt.shiftwidth = 2
--
-- Number of spaces that a <Tab> counts for while performing editing
-- operations, like inserting a <Tab> or using <BS>.
vim.opt.softtabstop = 2
--
-- Set how many columns of whitespace a <Tab> is worth.
vim.opt.tabstop = 2
