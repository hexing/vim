function! hexing#vim_hx#HX_KeyPress_Return()
	let l:arr1 = ['^\s*\<function\>','^\s*\<while\>','^\s*\<for\>','^\s*\<if\>']
	let l:arr2 = ['endfunction','endwhile','endfor','endif']

	let l:lCur = getline('.')
	let l:lNxt = getline(line('.')+1)

	let l:i = 0
	for m in l:arr1
		if l:lCur =~ m
			"let l:nt = '^\s*\<' . l:arr2[l:i] . '\>'
			"if l:lNxt !~ l:nt
				return "\<CR>" . l:arr2[l:i] . "\<Up>\<End>\<CR>"
			"endif
		endif
		let l:i += 1
	endfor

	return "\<CR>"
endfunction

function! hexing#vim_hx#HX_KeyPress_Escape()
	let l:lCur = getline('.')
	if l:lCur =~ '^\s*$'
		let l:lNxt = getline(line('.')+1)
		if l:lNxt =~ '^\s*end.\+$'
			return "\<Esc>dd"
		endif
	endif

	return "\<Esc>"
endfunction
