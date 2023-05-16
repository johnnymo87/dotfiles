" Turn tabs into spaces.
set expandtab
" Copy the structure of the existing lines indent when autoindenting a new
" line.
set copyindent
" When changing the indent of the current line, preserve as much of the indent
" structure as possible.
set preserveindent
" Set how many columns of whitespace a level of indentation is worth.
set shiftwidth=2
" Number of spaces that a <Tab> counts for while performing editing
" operations, like inserting a <Tab> or using <BS>.
set softtabstop=2
" Set how many columns of whitespace a <Tab> is worth.
set tabstop=2

" Shortcut for setting a debugger.
nnoremap <buffer> <leader>db :normal odebugger; // eslint-disable-line no-debugger<ESC>
