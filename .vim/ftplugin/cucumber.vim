" Copy file:line into register for use in RunSpec and RunCuke.
nnoremap <buffer> <leader>oo :let @f= @% . ':' . line('.')<CR>
nnoremap <buffer> <leader>oo :let @f= @% . ':' . line('.')<CR>

" Run Cucumber in a horizontal terminal.
nnoremap <buffer> <leader>0u :call ruby#RunCuke(':terminal', @f)<CR>
nnoremap <buffer> <leader>9u :call ruby#RunCuke(':terminal', ruby#StripLineNumber(@f))<CR>

" Close the buffers left open by RunSpec or RunCuke.
nnoremap <buffer> <leader>kp :bdelete! <C-r>s<CR>
