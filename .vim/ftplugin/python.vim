" https://realpython.com/vim-and-python-a-match-made-in-heaven/
" This will give you the standard four spaces when you hit tab and store the
" file in a Unix format so you don't get a bunch of conversion issues when
" checking into GitHub and/or sharing with other users.
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix

" Single indent rather than double indent
" https://stackoverflow.com/a/62348570/2197402
let g:pyindent_open_paren=shiftwidth()

" Shortcut for setting a debugger
map <buffer> <leader>db :normal oimport pdb; pdb.set_trace()<ESC>
