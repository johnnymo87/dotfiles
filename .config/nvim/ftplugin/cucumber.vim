" 'Copy File' into a register for use in RunSpec and RunCuke.
nnoremap <buffer> <leader>cf :let @f= @%<CR>
" 'Copy File & Line' into a register for use in RunSpec and RunCuke.
nnoremap <buffer> <leader>cfl :let @f= @% . ':' . line('.')<CR>

" Map 'rcv' to mean 'Run Cuke in a Vertical terminal'.
nnoremap <buffer> <leader>rcv :call ruby#RunCuke(':vsplit\|:terminal', @f)<CR>
" Map 'rch' to mean 'Run Cuke in a Horizontal terminal'.
nnoremap <buffer> <leader>rch :call ruby#RunCuke(':split\|:terminal', @f)<CR>
