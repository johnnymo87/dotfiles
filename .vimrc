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

set t_Co=256
let g:solarized_termcolors=256
syntax enable " Enable syntax highlighting
colorscheme monokai

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
" Move between split windows by using the four directions H, L, I, N
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j

" In normal mode or in insert mode, press Alt-j to move the current line down,
" or press Alt-k to move the current line up.
"
" After visually selecting a block of lines (for example, by pressing V then
" moving the cursor down), press Alt-j to move the whole block down, or press
" Alt-k to move the block up.

" Mac
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ > <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Linux
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" ================ Ruby ========================

nnoremap <leader>db :normal orequire 'pry'; ::Kernel.binding.pry<ESC>

function! RunSpec(runner, fileAndLineNumber)
  exe 'wa'
  exe a:runner . ' rspec ' . a:fileAndLineNumber . ' --format documentation --color'
endfunction

function! RunCuke(runner, fileAndLineNumber)
  exe 'wa'
  exe a:runner . ' cucumber ' . a:fileAndLineNumber . ' -r features/'
endfunction

function! StripLineNumber(fileAndLineNumber)
  return substitute(a:fileAndLineNumber, '\(:.*\)', '', '')
endfunction

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

function! FindSourceOrSpec()
  if match(@%, '\v^app/assets/javascripts/') != -1
    return substitute(@%, '\v^(app/assets/javascripts/)(.*)(\.es6)$', 'app/assets/test/\2.spec.es6', '')
  elseif match(@%, '\v\.spec\.es6') != -1
    return substitute(@%, '\v^(app/assets/test/)(.*)(\.spec\.es6)$', 'app/assets/javascripts/\2.es6', '')
  elseif match(@%, '\v_spec\.rb') != -1
    return substitute(@%, '\v^(spec)(.*)(_spec\.rb)$', 'app\2.rb', '')
  elseif match(@%, '\v^app.*\.rb') != -1
    return substitute(@%, '\v^(app)(.*)(\.rb)$', 'spec\2_spec.rb', '')
  endif
endfunction

nnoremap ,1x :call SplitPairOverNewline()<CR>

function! SplitPairOverNewline()
  normal a
  normal k$%i
endfunction


nnoremap <leader>ss :exe 'vsp ' . FindSourceOrSpec()<CR>

nnoremap <leader>oo :let @f= @% . ':' . line('.')<CR>
nnoremap <leader>0p :call RunSpec('!', @f)<CR>
nnoremap <leader>9p :call RunSpec('!', StripLineNumber(@f))<CR>

nnoremap <leader>uu :let @g= @% . ':' . line('.')<CR>
nnoremap <leader>0i :call RunCuke('!', @g)<CR>
nnoremap <leader>9i :call RunCuke('!', StripLineNumber(@g))<CR>

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
