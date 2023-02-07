" Map 'cf' to mean 'Copy File' into a register for use in RunCuke.
nnoremap <buffer> <leader>cf :let @f= @%<CR>
" Map 'cfl' to mean 'Copy File & Line' into a register for use in RunCuke.
nnoremap <buffer> <leader>cfl :let @f= @% . ':' . line('.')<CR>

" Map 'rcv' to mean 'Run Cuke in a Vertical terminal'.
nnoremap <buffer> <leader>rcv :call ruby#RunCuke(':vertical terminal', @f)<CR>
" Map 'rch' to mean 'Run Cuke in a Horizontal terminal'.
nnoremap <buffer> <leader>rch :call ruby#RunCuke(':terminal', @f)<CR>

" Map 'bdt' to mean 'Buffer Delete Test'.
" Closes the buffers left open by RunSpec or RunCuke.
" <C-r>s spits out what's in register s. RunSpec and RunCuke save their buffer
" number to it, so we send it to the buffer delete command.
nnoremap <buffer> <leader>bdt :bdelete! <C-r>s<CR>
