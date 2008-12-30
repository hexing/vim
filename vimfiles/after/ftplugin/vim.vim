setlocal formatoptions-=r formatoptions-=o

inoremap <buffer> <silent> < <C-R>=hexing#hexing_autoload#HX_paire('<')<CR>
inoremap <buffer> <silent> > <C-R>=hexing#hexing_autoload#HX_paire('>')<CR>
