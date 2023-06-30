" Plugins installed by vim-plug.
"
" After adding plugins, reload (:source ~/.config/nvim/init.vim) or restart
" Vim. Then run :PlugInstall to install the plugins.
"
" For more, see https://github.com/junegunn/vim-plug/wiki/tutorial.

" Plugins are installed in ~/.local/share/nvim/plugged by default.
call plug#begin()

" GitHub Copilot uses OpenAI Codex to suggest code and entire functions in
" real-time right from your editor. Trained on billions of lines of public
" code, GitHub Copilot turns natural language prompts including comments and
" method names into coding suggestions across dozens of languages.
Plug 'github/copilot.vim'

" Runs ripgrep from vim and shows the results in a quickfix window. Better than
" some fancy neovim knockoffs, which although they can do async jobs, they're
" restricted in how they pass arguments to ripgrep, which is a deal breaker.
" In contrast, this plugin has figured that all out.
Plug 'jremmen/vim-ripgrep'

" Syntax file and other settings for TypeScript.
Plug 'leafgarland/typescript-vim'

" For automatically generating and updating ctags.
"
" Depends on some sort of ctags software being already
" installed. I recommend Universal Ctags, because it seeks to maintain the
" popular but now-abandoned Exuberant Ctags.
Plug 'ludovicchabant/vim-gutentags'

" A Vim plugin for the Fugitive Git wrapper.
Plug 'tpope/vim-fugitive'

call plug#end()

" Change leader to a comma because the backslash is too far away.
let mapleader=','

" Display tabs and trailing spaces visually.
set list listchars=tab:▷▷⋮,trail:·

" Strip trailing whitespaces.
nnoremap <leader>s :%s/\s\+$//e<CR>

" Simplify getting back to Normal mode after entering Terminal in Insert mode.
" Map it to Ctrl-w a, which isn't mapped to anything by default.
tnoremap <C-W>a <C-\><C-n>

" Copy current file's path to system buffer.
nnoremap <leader>cp :let @+=@%<CR>

" Don't wrap lines by default.
set nowrap

" Line numbers are good!
set number

" A visual guide for my column soft and hard limits.
highlight ColorColumn ctermbg=235 guibg=#2c2d27
set colorcolumn=80,121

" Use system clipboard by default.
" https://stackoverflow.com/a/30691754/2197402
set clipboard^=unnamed,unnamedplus

" Search options.
"
" * 'ic', 'ignorecase',   Ignore upper/lower case when searching.
" * 'is', 'incsearch',    Show partial matches for a search phrase.
" * 'hls', 'hlsearch',    Highlight all matching phrases.
set ignorecase hlsearch incsearch

" Configure netrw, the built-in file explorer.
"
" Let me Ctrl-O/Ctrl-I between the file explorer and the current buffer.
" https://stackoverflow.com/a/58857795/2197402
let g:netrw_keepj=''

" `matchit.vim` is built-in so let's enable it!
" E.g. press `%` on `if` to jump to `else`.
runtime macros/matchit.vim

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb
