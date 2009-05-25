function!  hexing#make_hx#HX_make() "{{{3
	exec "silent! normal! :update\<CR>"
	exec "silent! normal! :make! -f % --quiet\<CR>"
	if (0 == v:shell_error)
		exec "silent! normal! :cw\<CR>"
	else
		exec "silent! normal! :copen\<CR>"
	endif
endfunction
