" Do not turn tabs into spaces.
set noexpandtab
" Copy the structure of the existing lines indent when autoindenting a new
" line.
set copyindent
" When changing the indent of the current line, preserve as much of the indent
" structure as possible.
set preserveindent
" Disable 'softtabstop' so pressing <Tab> then gets you a regular tab forward.
set softtabstop=0
" Set how many columns of whitespace a level of indentation is worth.
set shiftwidth=4
" Set how many columns of whitespace a <Tab> is worth.
set tabstop=8

" See :help cinoptions-values for more details on what can be configured and
" :help C-indenting for information on C indenting in general.
" Set indent to be two times the shiftwidth.
set cindent
set cinoptions=>2s

" https://alldrops.info/posts/vim-drops/2021-07-08_tabs-and-spaces-in-vim/
" When displaying invisible characters, display tabs this way.
" set list listchars=tab:▷▷⋮,trail:·
" Map shortcut for toggling setting to make invisible characters visible.
"" nnoremap <buffer> <leader><Tab><Tab> :set invlist<CR>
