" Turn tabs into spaces.
set expandtab
" Copy the structure of the existing lines indent when autoindenting a new
" line.
set copyindent
" When changing the indent of the current line, preserve as much of the indent
" structure as possible.
set preserveindent

" Shortcut for setting a debugger
nnoremap <buffer> <leader>db :normal odebugger; // eslint-disable-line no-debugger<ESC>
