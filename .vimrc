scriptencoding utf-8
set encoding=utf-8

" Turn off vi compatibility
set nocompatible " We're running Vim, not Vi!

" ================ Turn Off Mouse ==============
" https://stackoverflow.com/a/52067797/2197402

set mouse=a

nmap <ScrollWheelUp> <nop>
nmap <S-ScrollWheelUp> <nop>
nmap <C-ScrollWheelUp> <nop>
nmap <ScrollWheelDown> <nop>
nmap <S-ScrollWheelDown> <nop>
nmap <C-ScrollWheelDown> <nop>
nmap <ScrollWheelLeft> <nop>
nmap <S-ScrollWheelLeft> <nop>
nmap <C-ScrollWheelLeft> <nop>
nmap <ScrollWheelRight> <nop>
nmap <S-ScrollWheelRight> <nop>
nmap <C-ScrollWheelRight> <nop>

imap <ScrollWheelUp> <nop>
imap <S-ScrollWheelUp> <nop>
imap <C-ScrollWheelUp> <nop>
imap <ScrollWheelDown> <nop>
imap <S-ScrollWheelDown> <nop>
imap <C-ScrollWheelDown> <nop>
imap <ScrollWheelLeft> <nop>
imap <S-ScrollWheelLeft> <nop>
imap <C-ScrollWheelLeft> <nop>
imap <ScrollWheelRight> <nop>
imap <S-ScrollWheelRight> <nop>
imap <C-ScrollWheelRight> <nop>

vmap <ScrollWheelUp> <nop>
vmap <S-ScrollWheelUp> <nop>
vmap <C-ScrollWheelUp> <nop>
vmap <ScrollWheelDown> <nop>
vmap <S-ScrollWheelDown> <nop>
vmap <C-ScrollWheelDown> <nop>
vmap <ScrollWheelLeft> <nop>
vmap <S-ScrollWheelLeft> <nop>
vmap <C-ScrollWheelLeft> <nop>
vmap <ScrollWheelRight> <nop>
vmap <S-ScrollWheelRight> <nop>
vmap <C-ScrollWheelRight> <nop>

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Indentation ======================
set expandtab
set shiftwidth=2
set softtabstop=2
set smartindent
set autoindent

" Load indent file for the current filetype
filetype on        " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on " Enable filetype-specific plugins

" Change leader to a comma because the backslash is too far away
let mapleader=","

" Display tabs and trailing spaces visually
set list listchars=tab:▷▷⋮,trail:·

set number       "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points
set visualbell                  "No sounds

" ================ Folds ============================

set foldmethod=indent   " fold based on indent
set nofoldenable        " don't fold by default

" ================ Searching ========================

" Make search not case sensitive
set ignorecase
" Unless search contains an upcased letter
set smartcase
" Highlight all search pattern matches
set hlsearch
" Very no-magic mode search for visually selected text
vnoremap * y/\V<C-R>"<CR>
vnoremap # y?\V<C-R>"<CR>

" ================ Custom Settings ========================

" Show the `line,column` numbers in the status bar
set ruler

syntax enable " Enable syntax highlighting

" A visual guide for my column soft and hard limits
highlight ColorColumn ctermbg=235 guibg=#2c2d27
set colorcolumn=80,121

" TODO Don't lose clipboard when quitting/suspending vim
" https://stackoverflow.com/questions/6453595/prevent-vim-from-clearing-the-clipboard-on-exit

" https://stackoverflow.com/a/30691754/2197402
set clipboard^=unnamed,unnamedplus "Use system clipboard by default
set showcmd "Show key presses in normal mode
set iskeyword-=_ "recognize underscore as word break

" Copy current file's path to system buffer.
nnoremap <leader>cp :let @+=@%<CR>

" Strip trailing whitespaces.
nnoremap <leader>s :%s/\s\+$//e<CR>

" Make Y consistent with C and D.
nnoremap Y y$

" Simplify getting back to Normal mode after entering Terminal in Insert mode.
" Map it to Ctrl-w a, which isn't mapped to anything by default.
tnoremap <C-W>a <C-\><C-n>

" `matchit.vim` is built-in so let's enable it!
" Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim

" ==== gruvbox
" Switch to dark color scheme
set background=dark
" Turn the contrast all the way up
let g:gruvbox_contrast_light='hard'
let g:gruvbox_contrast_dark='hard'
" Then enable it
" autocmd vimenter * ++nested colorscheme gruvbox
colorscheme gruvbox

" ==== NERD tree
nnoremap <silent> <leader>. :NERDTreeFind<CR>:vertical res 30<CR>
nnoremap <silent> <leader>/ :NERDTreeClose<CR>
let NERDTreeShowHidden=1 " Show hidden files by default

" ==== vim-ripgrep
nnoremap <leader>gg :Rg ""<left>

" ==== Fuzzy finder CtrlP
nnoremap <silent> <leader>t :CtrlP<CR>
let g:ctrlp_custom_ignore = 'node_modules\|git'

" ==== YouCompleteMe
" Jump to definition
nnoremap <leader>jd :YcmCompleter GoTo<CR>

" associate *.es6 with javascript filetype
au BufRead,BufNewFile *.es6 set filetype=javascript

" associate *.json with json filetype
au BufRead,BufNewFile *.json set filetype=json

" use jsx syntax plugin on non-.jsx files
let g:jsx_ext_required = 0

" ==== Syntastic
" use custom js linter from https://github.com/jaxbot/syntastic-react
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_json_checkers=['jsonlint']
" disable syntastic checks in handlebar templates
" https://github.com/vim-syntastic/syntastic/issues/240
let syntastic_mode_map = { 'passive_filetypes': ['html'] }
" Use python 3
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python']

" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure
