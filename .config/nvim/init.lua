-- Plugins installed by vim-plug.
--
-- After adding plugins, reload (source ~/.config/nvim/init.lua) or restart
-- Neovim. Then run :PlugInstall to install the plugins.
--
-- For more, see https://github.com/junegunn/vim-plug/wiki/tutorial.
--
-- Plugins are installed in ~/.local/share/nvim/plugged by default.
local Plug = vim.fn["plug#"]
vim.call("plug#begin")
--
-- GitHub Copilot uses OpenAI Codex to suggest code and entire functions in
-- real-time right from your editor. Trained on billions of lines of public
-- code, GitHub Copilot turns natural language prompts including comments and
-- method names into coding suggestions across dozens of languages.
Plug("github/copilot.vim")
--
-- Runs ripgrep from vim and shows the results in a quickfix window. Better than
-- some fancy neovim knockoffs, which although they can do async jobs, they"re
-- restricted in how they pass arguments to ripgrep, which is a deal breaker.
-- In contrast, this plugin has figured that all out.
Plug("jremmen/vim-ripgrep")
--
-- Syntax file and other settings for TypeScript.
Plug("leafgarland/typescript-vim")
--
-- For automatically generating and updating ctags.
-- Depends on some sort of ctags software being already
-- installed. I recommend Universal Ctags, because it seeks to maintain the
-- popular but now-abandoned Exuberant Ctags.
Plug("ludovicchabant/vim-gutentags")
--
-- Contains some useful lua functions. (A dependency of telescope.nvim.)
Plug("nvim-lua/plenary.nvim")
--
-- A native telescope sorter that significantly improve sorting performance. (A
-- dependency of telescope.nvim.)
Plug("nvim-telescope/telescope-fzy-native.nvim")
--
-- A fuzzy finder. It helps you search, filter, find and pick things.
Plug("nvim-telescope/telescope.nvim", { branch = "0.1.x"})
--
-- A parser generator tool and an incremental parsing library. It can build a
-- concrete syntax tree for a source file and efficiently update the syntax
-- tree as the source file is edited.
-- A plugin that uses treesitter to provide text objects, folding, syntax
-- highlighting, indentation, and more.
-- It uses it to provide a preview of the search results.
Plug("nvim-treesitter/nvim-treesitter", {["do"]= ":TSUpdate"})
--
-- A Vim plugin for the Fugitive Git wrapper.
Plug("tpope/vim-fugitive")
--
vim.call("plug#end")

-- Change leader to a comma because the backslash is too far away.
vim.g.mapleader = ","

-- Display tabs and trailing spaces visually.
vim.opt.list = true
vim.opt.listchars = "tab:▷▷⋮,trail:·"

-- Strip trailing whitespaces.
vim.api.nvim_set_keymap("n", "<leader>s", ":%s/\\s\\+$//e<CR>", {noremap = true})

-- Simplify getting back to Normal mode after entering Terminal in Insert mode.
-- Map it to Ctrl-w a, which isn"t mapped to anything by default.
vim.api.nvim_set_keymap("t", "<C-W>a", "<C-\\><C-n>", {noremap = true})

-- Copy current file"s path to system buffer.
vim.api.nvim_set_keymap("n", "<leader>cp", ":let @+=@%<CR>", {noremap = true})

-- Jump-start a vim-ripgrep search.
vim.api.nvim_set_keymap("n", "<leader>rr", ":Rg ''<left>", {noremap = true})

-- Jump-start a :Git (Fugitive) command.
vim.api.nvim_set_keymap("n", "<leader>gg", ":Git ", {noremap = true})

-- Tree-sitter based folding.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- Don"t wrap lines by default.
vim.opt.wrap = false

-- Line numbers are good!
vim.opt.number = true

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

-- Load configuration for plugins.
require("user.telescope")
-- require("user.tree-sitter")
