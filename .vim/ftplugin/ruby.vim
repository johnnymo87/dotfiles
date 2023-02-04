" Shortcut for setting a debugger
nnoremap <buffer> <leader>db :normal orequire 'pry'; ::Kernel.binding.pry<ESC>

" Transform parens from single-line to multi-line.
nnoremap <buffer> <leader>1w :call ruby#OpenParens()<CR>

" Transform curlies into do/end block.
nnoremap <buffer> <leader>1s :call ruby#OpenCurlies()<CR>

" ?
nnoremap <buffer> <leader>1x :call ruby#SplitPairOverNewline()<CR>

" Open source/spec file respective pair in vertical pane.
nnoremap <buffer> <leader>ss :exe 'vsp ' . ruby#FindSourceOrSpec()<CR>

" Copy file:line into register for use in RunSpec and RunCuke.
nnoremap <buffer> <leader>oo :let @f= @% . ':' . line('.')<CR>

" Run RSpec in a vertical terminal.
nnoremap <buffer> <leader>0p :call ruby#RunSpec(':vertical terminal', @f)<CR>
nnoremap <buffer> <leader>9p :call ruby#RunSpec(':vertical terminal', ruby#StripLineNumber(@f))<CR>

" Run Cucumber in a horizontal terminal.
nnoremap <buffer> <leader>0u :call ruby#RunCuke(':terminal', @f)<CR>
nnoremap <buffer> <leader>9u :call ruby#RunCuke(':terminal', ruby#StripLineNumber(@f))<CR>

" Close the buffers left open by RunSpec or RunCuke.
nnoremap <buffer> <leader>kp :bdelete! <C-r>s<CR>
