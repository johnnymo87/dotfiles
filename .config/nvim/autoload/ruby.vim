" Run RSpec.
" Save buffer number to register s, so that we can reference it later when we
" want to delete this buffer.
function! ruby#RunSpec(runner, fileAndLineNumber)
  exe 'wa'
  exe a:runner . ' bundle exec rspec --format documentation --fail-fast ' . a:fileAndLineNumber
  exe 'let @s= bufnr("%")'
endfunction

" Run cucumber.
" Save buffer number to register s, so that we can reference it later when we
" want to delete this buffer.
function! ruby#RunCuke(runner, fileAndLineNumber)
  exe 'wa'
  exe a:runner . ' bundle exec cucumber --publish-quiet ' . a:fileAndLineNumber
  exe 'let @s= bufnr("%")'
endfunction

" Transform parens from single-line to multi-line.
function! ruby#OpenParens()
  s:(:(\r
  s:):\r)
  normal k
  s:,:,\r:g
  noh
  normal jv%=
endfunction

" Transform curlies into do/end block.
function! ruby#OpenCurlies()
  s:{:do\r:
  s: }:\rend:
  normal Vkk=jj
  noh
endfunction

" ?
function! ruby#SplitPairOverNewline()
  normal a
  normal k$%i
endfunction

" Find source/spec file respective pair.
function! ruby#FindSourceOrSpec()
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
