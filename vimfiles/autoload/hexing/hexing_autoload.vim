"variables {{{1
let s:IsInHxCmp = 0

let s:HX_cpp_dictionary = [
			\{'word':"_(\"\")", 'abbr':'_("")', 'menu':"h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"_T(\"\")", 'abbr':'_T("")', 'menu':"h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"_T('')", 'abbr':'_T('''')', 'menu':"h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\
			\{'word':"if ()", 'abbr':'if()', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"if ()\n{\n}", 'abbr':'if(){}', 'menu':"2k$", 'info':'info', 'kind':'f', 'icase':1, 'dup':0},
			\{'word':"elseif ()", 'abbr':'elseif()', 'menu':"", 'info':'info', 'kind':'m', 'icase':1, 'dup':1},
			\{'word':"elseif ()\n{\n}", 'abbr':'elseif(){}', 'menu':"2k$", 'info':'info', 'kind':'m', 'icase':1, 'dup':1},
			\{'word':"for ()\n{\n}", 'abbr':'for(){}', 'menu':"2k$", 'info':'info', 'kind':'m', 'icase':1, 'dup':1},
			\{'word':"switch ()\n{\ncase 1:\nbreak;\ndefault:\nbreak;\n}", 'abbr':'switch()', 'menu':"4k$X2k$", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"case 1:\nbreak;", 'abbr':'case', 'menu':"k$X", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"#ifdef DEBUG\n#endif", 'abbr':'#ifDEBUG', 'menu':"ko", 'info':'info', 'kind':'f', 'icase':1, 'dup':0}, 
			\
			\{'word':"dynamic_cast<>()", 'abbr':'dynamic_cast', 'menu':"2h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"reinterpret_cast<>()", 'abbr':'reinterpret_cast', 'menu':"2h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"static_cast<>()", 'abbr':'static_cast', 'menu':"2h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"const_cast<>()", 'abbr':'const_cast', 'menu':"2h", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\
			\{'word':"mutable ", 'abbr':'mutable', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"virtual ", 'abbr':'virtual', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"unsigned ", 'abbr':'unsigned', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"explicit ", 'abbr':'explicit', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"operator ", 'abbr':'operator', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"typedef ", 'abbr':'typd', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\{'word':"typename ", 'abbr':'typn', 'menu':"", 'info':'info', 'kind':'v', 'icase':1, 'dup':1},
			\]

"functions {{{1
"complete functions {{{2
		function! s:HX_getCurWordBeg() "{{{3
            let l:line = getline('.')
            let l:start = col('.') - 1
            while l:start > 0 && l:line[l:start - 1] !~ '\s'
              let l:start -= 1
            endwhile
            return l:start
		endfunction

		"function! hexing#hexing_autoload#HX_cpp_user_complete(findstart, base) "{{{3
		"	if a:findstart
		"		let l:begin = <SID>HX_getCurWordBeg()
		"		let l:count = col('.') - l:begin - 1
		"		if l:count > 0
		"			let l:str = strpart(getline('.'), l:begin, l:count)
		"		else
		"			let l:str = ''
		"		endif
		"		let l:pos = l:begin
		"		
		"		if '' != l:str
		"			let l:i = 0
		"			while l:i < l:count
		"				let l:s = strpart(l:str, l:i, l:count - l:i)
		"				for m in s:HX_cpp_dictionary
		"					if m['abbr'] =~ '^' . l:s
		"						let l:pos -= l:i
		"						break
		"					endif
		"				endfor

		"				let l:i += 1
		"			endwhile
		"		endif

		"		return l:pos
		"	else
		"		" 寻找匹配 "a:base" 的
		"		for m in s:HX_cpp_dictionary 
		"			if m['abbr'] =~ '^' . a:base
		"				call complete_add(m['abbr'])
		"			endif
		"			if complete_check()
		"				break
		"			endif
		"		endfor
		"		let s:IsInHxCmp = 1
		"		return []
		"	endif
		"endfunction

		function! s:HX_get_complete_array(base) "{{{3
			let l:arr = []
			for m in s:HX_cpp_dictionary
				if m['abbr'] =~ '^' . a:base
					call add(l:arr, m['abbr'])
				endif
			endfor
			return l:arr
		endfunction

		function! hexing#hexing_autoload#HX_popup_setion_completion(base_str) "{{{3
			let l:base = a:base_str
			if '*' == l:base
				let l:line = getline('.')
				let l:begin = s:HX_getCurWordBeg()
				let l:count = col('.') - l:begin - 1
				if l:count > 0
					let l:base = strpart(l:line, l:begin, l:count)
				else
					let l:base = ''
				endif
			endif

			let l:arr = s:HX_get_complete_array(l:base)
			let l:pos = col('.')

			if empty(l:arr)
				let l:i = strlen(l:base) - 1
				let l:s = ''
				while l:i > -1
					let l:s = l:base[i] . l:s
					let l:arr = s:HX_get_complete_array(l:s)

					if !empty(l:arr)
						let l:pos -= strlen(l:base) - l:i
						break
					endif
					let l:i -= 1
				endwhile
				
				if empty(l:arr)
					for m in s:HX_cpp_dictionary
						call add(l:arr, m['abbr'])
					endfor
				endif
			else
				let l:pos -= strlen(l:base)
			endif

			call complete(l:pos, l:arr)
			let s:IsInHxCmp = 1
			return ''
		endfunction

		function! s:HX_do_setion_complete(base, word, motion) "{{{3
			let l:line = getline('.')
			let l:action = 'silent! normal! '
			if col('.') > strlen(l:line)
				let l:action = l:action . (strlen(a:base) - 1) . 'XxA'
			else
				let l:action = l:action . strlen(a:base) . 'Xi'
			endif
			let l:action = l:action . a:word
			exe l:action

			if strlen(a:motion) > 0
				exe 'silent! normal! ' . a:motion
			endif
		endfunction

		function! hexing#hexing_autoload#HX_setion_complete() "{{{3
			if 0 == s:IsInHxCmp
				return ''
			endif
			let s:IsInHxCmp = 0

			let l:line = getline('.')
			let l:begin = s:HX_getCurWordBeg()
			let l:count = col('.') - l:begin - 1
			let l:base = ''

			if l:count > 0
				let l:base = strpart(l:line, l:begin, l:count)
				let l:len = strlen(l:base)

				if l:len > 0
					for m in s:HX_cpp_dictionary
						if m['abbr'] == l:base
							call s:HX_do_setion_complete(l:base, m['word'], m['menu'])
							return ''
						elseif l:base =~ m['abbr'] . '$'
							call s:HX_do_setion_complete(m['abbr'], m['word'], m['menu'])
							return ''
						endif
					endfor
				endif
			endif

			return ''
		endfunction

"Align functions {{{2
function! hexing#hexing_autoload#HX_align_word_column(ln_beg, ln_end) "{{{3
		"befor check {{{4
		let l:b = a:ln_beg
		let l:e = a:ln_end
		if l:b < 1
			let l:b = 1
		endif
		if l:e > line('$')
			let l:e = line('$')
		endif
		if l:b >= l:e
			return
		endif
		"}}}4

		"before {{{4
		let l:ve_save = &virtualedit
		setlocal virtualedit=
		exe 'silent! normal! :' . l:b . ',' . l:e . "left\<CR>"
		"}}}4

		"get lines array {{{4
		let l:ln_num = []
		let l:i = l:b
		while l:i <= l:e
			call add(l:ln_num, i)
			let l:i += 1
		endwhile
		"}}}4

		let l:i = 1
		while 1
			let l:arr_ln = []
			let l:arr_vcol = []

			for l:it in l:ln_num "get lines and columns {{{4
				let l:pos = 0
				let l:k = 0
				while l:k < l:i
					let l:pos = matchend(getline(l:it), '\s\+\S', l:pos)
					if l:pos < 1
						break
					endif
					let l:k += 1
				endwhile

				if l:pos > 1
					call add(l:arr_ln, l:it) 

					call cursor(l:it, l:pos)
					"exe 'silent! normal! ' . (l:pos - 1) . 'l'
					call add(l:arr_vcol, virtcol('.'))
				endif
			endfor "}}}4

			let l:len = len(l:arr_ln)
			if 0 == l:len
				break
			endif
			let l:ln_num = l:arr_ln
			let l:max_vcol = max(l:arr_vcol)

			let l:k = 0
			"set virtualedit=all
			while l:k < l:len "align {{{4
				let l:ln = get(l:arr_ln, l:k)
				let l:vcol = get(l:arr_vcol, l:k)
				if l:vcol < l:max_vcol
					call cursor(l:ln, 1)
					"exe 'silent! normal! ' . l:vcol . '|"zd$' . l:max_vcol . '|' . '"zP'
					exe 'silent! normal! ' . l:vcol . '|"zd$'
					while virtcol('.') < l:max_vcol
						exe "silent! normal! a\<Tab>"
					endwhile
					setlocal virtualedit=all
					if virtcol('.') > l:max_vcol
						exe 'silent! normal! a' . "\<BS>"
						exe 'silent! normal! ' . l:max_vcol . '|'
					endif
					exe 'silent! normal! "zP'
					setlocal virtualedit=
				endif

				let l:k += 1
			endwhile "}}}4
			"set virtualedit=

			let l:i += 1
		endwhile

		"after {{{4
		let &virtualedit = l:ve_save
		call cursor(l:b, 1)
		exe 'silent! normal! =' . (l:e - l:b) . 'j'
		"}}}4
	endfunction

	function! hexing#hexing_autoload#HX_align_lines() range "{{{3
		if 'V' == visualmode()
			call hexing#hexing_autoload#HX_align_word_column(a:firstline, a:lastline)
		endif
	endfunction

"additional functions {{{2
	function! hexing#hexing_autoload#HX_toggle_quickfix_wnd() "{{{3 
		let l:buf_count = bufnr('$')
		let l:i = 1
		while l:i <= l:buf_count
			if 'quickfix' == getbufvar(bufname(l:i), '&buftype')
				break
			endif
			let l:i += 1
		endwhile
		let l:cmd = 'silent! :'
		if l:i <= l:buf_count
			let l:cmd = l:cmd . 'cclose'
		else
			let l:cmd = l:cmd . 'copen'
		endif
		exe l:cmd
	endfunction

	function!  hexing#hexing_autoload#HX_close_buffer() "{{{3
		let l:cmd = 'normal :'
		let l:buf_name = bufname('#')
		if bufexists(l:buf_name)
			let l:cmd = l:cmd . 'bwipeout'
		else
			let l:cmd = l:cmd . 'confirm quit'
		endif
		let l:cmd = l:cmd . "\<CR>"
		exe l:cmd
	endfunction

"keymap functions {{{2
	function!  hexing#hexing_autoload#HX_paire(ch) "{{{3
		let l:sCmd = a:ch

		let l:lel = '([{<'
		let l:ler = ')]}>'
		let l:count = strlen(l:lel)

		let l:i = 0
		while l:i < l:count
			if a:ch == l:lel[l:i]
				let l:sCmd = a:ch . l:ler[l:i] . "\<left>"
				return l:sCmd
			endif

			let l:i += 1
		endwhile

		let l:i = 0
		while l:i < l:count
			if a:ch == l:ler[l:i]
				let l:sCmd = <SID>HX_close_paire(l:lel[l:i], a:ch)
				return l:sCmd
			endif

			let l:i += 1
		endwhile

		let l:lel = "\"'"
		let l:count = strlen(l:lel)

		let l:i = 0
		while l:i < l:count
			if a:ch == l:lel[l:i]
				let l:sCmd = <SID>HX_close_paire(a:ch, a:ch)
				return l:sCmd
			endif

			let l:i += 1
		endwhile

		return l:sCmd
	endfunction

	function! <SID>HX_close_paire(l, r) "{{{3
		let l:sCmd = a:r
		if a:l==a:r
			let l:sCmd = a:l . a:r . "\<left>"
		endif

		let l:line = getline('.')
		let l:len = strlen(l:line)
		if l:len>0
			let l:chPrev = l:line[col('.')-2]
			let l:chNext = l:line[col('.')-1]
			if l:chPrev==a:l
				if l:chNext==a:r
					let l:sCmd = "\<Right>"
				else
					let l:sCmd = a:r . "\<left>"
				endif
			endif
		endif
		return l:sCmd
	endfunction

	function! <SID>HX_GetCtags() "{{{3
		if !exists('g:Ctags')
			let g_Ctags = 'ctags.exe'
		endif
	
		if 0 == strlen(g_Ctags) || !executable(g_Ctags)
			let g_Ctags = 'ctags.exe'
		endif
		return g_Ctags
	endfunction
	
	function! <SID>HX_GetTagFileName() "{{{3 
		if !exists('g:TagDirectory')
			return 'tags'
		endif
	
		let tagFile = expand('%:p:h') . '.tag'
		let tagFile = substitute(tagFile, ':', '%', '')
		let tagFile = substitute(tagFile, '/', '%', 'g')
		let tagFile = substitute(tagFile, '\', '%', 'g')
	
		if exists('g:TagDirectory')
			let tagFile = g:TagDirectory . '/' . tagFile
		endif
		return tagFile
	endfunction

	function! hexing#hexing_autoload#HX_CreateTagFile() "{{{3
		let CtagsCmd = <SID>HX_GetCtags()
		if !executable(CtagsCmd)
			call confirm('ctags is invalid!')
			return
		endif

		if exists('g:TagDirectory') && !isdirectory(g:TagDirectory)
			let nChoice = confirm(g:TagDirectory . " does not exist!\nDo you want to create the directory?\n" . g:TagDirectory, "&Ok\n&Cancel", 2)
			if 2 == nChoice
				return
			elseif 1 == nChoice
				let n = mkdir(g:TagDirectory, 'p')
				if 0 == n
					call confirm('Can not mkdir: ' . g:TagDirectory)
					return
				endif
			endif
		endif

		let tagFile = <SID>HX_GetTagFileName()
		if tagFile == findfile(tagFile)
			let nChoice = confirm("The file:\n" . tagFile . "\n already exists!" . "\nDo you want to continue?", "&Yes\n&No", 2)
			if 2 == nChoice
				return
			endif
		endif

		let s = expand('%:p:h')
		let s = 'ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f' . tagFile . ' ' . s
		let s = system(s)
		if 0 != v:shell_error
			call confirm(s)
		else
			call confirm("Success to build tag file:\n" . tagFile)
		endif
	endfunction

	function! hexing#hexing_autoload#HX_LoadTagFiles(sPath) "{{{3
		let s = a:sPath
		if 0 == strlen(s)
			if exists('g:TagDirectory') && isdirectory(g:TagDirectory)
				let s = g:TagDirectory
			else
				let s = expand('%:p:h') . '/*.tag'
			endif
			let s = inputdialog('请指定标签文件：', s)
		endif

		if 0 != strlen(s)
			if isdirectory(s)
				let s = s . '/*'
			endif
			let s = glob(s)
			if 0 != strlen(s)
				let &tags = &tags . ',' . substitute(s, '\n', ',', 'g')
			endif
		endif
	endfunction
