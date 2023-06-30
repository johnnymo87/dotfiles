" Shortcut for setting a debugger
nnoremap <buffer> <leader>db :normal orequire 'pry'; ::Kernel.binding.pry<ESC>

" Transform parens from single-line to multi-line.
nnoremap <buffer> <leader>1w :call ruby#OpenParens()<CR>

" Transform curlies into do/end block.
nnoremap <buffer> <leader>1s :call ruby#OpenCurlies()<CR>

" Open source/spec file respective pair in vertical pane.
nnoremap <buffer> <leader>ss :exe 'vsp ' . ruby#FindSourceOrSpec()<CR>

" 'Copy File' into a register for use in RunSpec and RunCuke.
nnoremap <buffer> <leader>cf :let @f= @%<CR>
" 'Copy File & Line' into a register for use in RunSpec and RunCuke.
nnoremap <buffer> <leader>cfl :let @f= @% . ':' . line('.')<CR>

" Map 'rsv' to mean 'Run rSpec in a Vertical terminal'.
nnoremap <buffer> <leader>rsv :call ruby#RunSpec(':vertical terminal', @f)<CR>
" Map 'rsh' to mean 'Run rSpec in a Horizontal terminal'.
nnoremap <buffer> <leader>rsh :call ruby#RunSpec(':terminal', @f)<CR>

" Map 'rcv' to mean 'Run Cuke in a Vertical terminal'.
nnoremap <buffer> <leader>rcv :call ruby#RunCuke(':vertical terminal', @f)<CR>
" Map 'rch' to mean 'Run Cuke in a Horizontal terminal'.
nnoremap <buffer> <leader>rch :call ruby#RunCuke(':terminal', @f)<CR>

" Map 'bdt' to mean 'Buffer Delete Test'.
" Closes the buffers left open by RunSpec or RunCuke.
" <C-r>s spits out what's in register s. RunSpec and RunCuke save their buffer
" number to it, so we send it to the buffer delete command.
nnoremap <buffer> <leader>bdt :bdelete! <C-r>s<CR>
