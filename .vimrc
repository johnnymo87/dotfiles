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
set list listchars=tab:\ \ ,trail:·

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

" 80 character delimiter
highlight ColorColumn ctermbg=235 guibg=#2c2d27
set colorcolumn=81 "vertical bar at right of column 80

" TODO Don't lose clipboard when quitting/suspending vim
" https://stackoverflow.com/questions/6453595/prevent-vim-from-clearing-the-clipboard-on-exit

" https://stackoverflow.com/a/30691754/2197402
set clipboard^=unnamed,unnamedplus "Use system clipboard by default
set showcmd "Show key presses in normal mode
set iskeyword-=_ "recognize underscore as word break

nnoremap <leader>l :update<cr>

nnoremap <leader>cp :let @+=@%<CR> " copy current file's path to system buffer

nnoremap <leader>s :%s/\s\+$//e<CR> " strip trailing whitespaces

"make Y consistent with C and D
nnoremap Y y$

" ==============================
" Window/Tab/Split Manipulation
" ==============================
" Move between split windows by using the four directions H, J, K, L
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j

" ==== Split things over new lines

function! OpenParens()
  s:(:(\r
  s:):\r)
  normal k
  s:,:,\r:g
  noh
  normal jv%=
endfunction

nnoremap <leader>1w :call OpenParens()<CR>

function! OpenCurlies()
  s:{:do\r:
  s: }:\rend:
  normal Vkk=jj
  noh
endfunction

nnoremap <leader>1s :call OpenCurlies()<CR>

nnoremap ,1x :call SplitPairOverNewline()<CR>

function! SplitPairOverNewline()
  normal a
  normal k$%i
endfunction


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
let g:ctrlp_custom_ignore = 'git'

" ==== Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Use clang-tidy for C++
let g:syntastic_cpp_checkers = ['clang-tidy']
let g:syntastic_cpp_clang_tidy_args = ['-p ~/Code/llvm-project/llvm']

" Project specific .vimrc files
" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure
