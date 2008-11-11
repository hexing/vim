source <sfile>:p:h/c.vim

syntax keyword cppExtention	__super

" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    command -nargs=+ HiLink hi link <args>
  else
    command! -nargs=+ HiLink hi def link <args>
  endif

  HiLink cppExtention		Statement
  delcommand HiLink
endif
