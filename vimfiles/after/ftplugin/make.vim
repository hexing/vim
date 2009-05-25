inoremap $ $()<Left>
inoremap <buffer> <silent> " <C-R>=hexing#hexing_autoload#HX_paire('"')<CR>
inoremap <buffer> <silent> <F7> <Esc>:call hexing#make_hx#HX_make()<CR>
nnoremap <buffer> <silent> <F7> :call hexing#make_hx#HX_make()<CR>
