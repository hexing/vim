"functions {{{1
"additional functions {{{2
function!  hexing#c_hx#HX_make(str) "{{{3
	exec "silent! normal! :update\<CR>"
	exec "silent! normal! :make! " .a:str. " --quiet\<CR>"
	if (0 == v:shell_error)
		exec "silent! normal! :cw\<CR>"
	else
		exec "silent! normal! :copen\<CR>"
	endif
endfunction

function! hexing#c_hx#HX_header_file() "{{{3
	let l:s=expand('%')
	let l:s=substitute(l:s,'\.','_','g')
	let l:s=toupper(l:s)
	let l:s='__'.l:s.'__'
	call append(0,'#ifndef '.l:s)
	call append(1,'#define '.l:s)
	call append(2,'')
	call append(3,'')
	call append(4,'')
	call append(5,'')
	call append(line('$'),'#endif //'.l:s)
	call cursor(5,1)
endfunction


"key map functions {{{2
function!  hexing#c_hx#HX_keymap_Enter() "{{{3
	let l:line = getline('.')
	let l:len = strlen(l:line)
	let l:chPrev = l:line[col('.')-2]
	let l:chNext = l:line[col('.')-1]

	if '{'==l:chPrev
		if '}'==l:chNext
			return "\<CR>\<Up>\<End>\<CR>"
		elseif ''==l:chNext
			return "}\<Left>\<CR>\<Up>\<End>\<CR>"
		endif
	endif

	if  l:line =~ '#if.*'
		let l:lNxt = getline(line('.')+1)
		if l:lNxt !~ '#else.*' && l:lNxt !~ '#endif.*'
			return "\<CR>#endif\<Up>\<End>\<CR>"
		endif
	endif

	return "\<CR>"
endfunction

function!  hexing#c_hx#HX_keymap_Dkh() "{{{3
	let l:lCur = getline('.')
	let l:lPrev = getline(line('.')-1)

	let l:arr = ['=\s*$','\<enum\>']
	for m in l:arr
		if l:lCur =~ m || l:lPrev =~ m
			return "{};\<Left>\<Left>"
		endif
	endfor

	let l:arr = ['\<class\>','\<struct\>','\<namespace\>', '\<union\>']
	for m in l:arr
		if l:lCur =~ m || l:lPrev =~ m
			return "{\<CR>};\<Up>\<End>\<CR>"
		endif
	endfor

	let l:arr = ['\<if\>','\<for\>','else', 'elseif']
	for m in l:arr
		if l:lCur =~ m || l:lPrev =~ m
			return "{\<CR>}\<Up>\<End>\<CR>"
		endif
	endfor

	if l:lCur =~ '\<while\>' || l:lPrev =~ '\<while\>'
		return "{\<CR>break;\<CR>}\<Up>\<Up>\<End>\<CR>"
	endif

	if l:lCur =~ '\<do\>' || l:lPrev =~ '\<do\>'
		"return "{\<CR>} while ();\<Up>\<End>\<CR>"
		return "{\<CR>} while ();\<Left>\<Left>"
	endif

	if l:lCur =~ 'switch\s*(.*)' || l:lPrev =~ 'switch\s*(.*)'
		return "{\<CR>};\<Up>\<End>\<CR>" . "case 1:\<CR>break;\<CR>" . "default:\<CR>break;" . "\<Up>\<Up>\<Up>\<Left>\<BS>"
	endif

	return hexing#hexing_autoload#HX_paire('{')
endfunction

function!  hexing#c_hx#HX_keymap_Colon() "{{{3
	let l:lCur = getline('.')
	let l:lNxt = getline(line('.')+1)

	if l:lNxt !~ '\<break\>;'
		if l:lCur =~ '\<case\>\s\+$'
			return "1:\<CR>break;\<Up>\<End>\<Left>\<BS>"
		elseif l:lCur =~ '\<case\>$'
			return " 1:\<CR>break;\<Up>\<End>\<Left>\<BS>"
		endif
	endif

	return ':'
endfunction

function! hexing#c_hx#HX_keymap_Escape() "{{{3
	let l:lCur = getline('.')
	if l:lCur =~ '^\s*$'
		let l:lPre = getline(line('.')-1)
		"if l:lPre =~ '^\s*\(\/\*.*\*\/\s*\)*{\s*\(\/\*.*\*\/\s*\)*\(\/\/.*\)*$'
		if l:lPre =~ '{'
			let l:lNxt = getline(line('.')+1)
			"if l:lNxt =~ '^\s*\(\/\*.*\*\/\s*\)*}\s*\(\/\*.*\*\/\s*\)*\(\/\/.*\)*$'
			if l:lNxt =~ '}'
				return "\<Esc>dd"
			endif
		endif
	endif
	return "\<Esc>"
endfunction

"commentfunctions {{{2
function! hexing#c_hx#HX_comment_c() range "{{{3
	let l:vm = visualmode()

	if char2nr('v') == char2nr(l:vm)
		if a:firstline == a:lastline
			let l:s = getline(a:firstline)
			let l:s = strpart(l:s, 0, col("'>")-1) . '*/' . strpart(l:s, col("'>")-1)
			let l:s = strpart(l:s, 0, col("'<")-1) . '/*' . strpart(l:s, col("'<")-1) 
			call setline(a:firstline, l:s)
		else
			let l:ss = getline(a:firstline)
			let l:ss = strpart(l:ss, 0, col("'<")-1) . '/*' . strpart(l:ss, col("'<")-1)
			call setline(a:firstline, l:ss)
			let l:st = getline(a:lastline)
			let l:st = strpart(l:st, 0, col("'>")-1) . '*/' . strpart(l:st, col("'>")-1)
			call setline(a:lastline, l:st)
		endif
	elseif char2nr('V') == char2nr(l:vm)
		if a:firstline == a:lastline
			let l:ln = getline(a:firstline)
			let l:len = strlen(l:ln)
			let l:i = 0
			while l:i < l:len
				if l:ln[l:i] !~ '\s'
					break
				endif
				let l:i += 1
			endwhile
			let l:ln = strpart(l:ln, 0, l:i) . '/*' . strpart(l:ln, l:i, l:len-l:i)
			let l:ln = l:ln . '*/'
			call setline(a:firstline, l:ln)
		else
			let l:lb = getline(a:firstline)
			let l:len = strlen(l:lb)
			let l:i = 0
			while l:i < l:len
				if l:lb[l:i] !~ '\s'
					break
				endif
				let l:i += 1
			endwhile
			let l:lb = strpart(l:lb, 0, l:i) . '/*' . strpart(l:lb, l:i, l:len-l:i)

			let l:line = getline(a:lastline) . '*/'
			call setline(a:firstline, l:lb)
			call setline(a:lastline, l:line)
		endif
	endif
endfunction

"{{{2
function! hexing#c_hx#HX_switch_h_cpp() range "{{{3
	let l:sDir=expand('%:p:h')
	let l:sFile=expand('%:r')
	let l:sExt=expand('%:e')

	let l:cf=['cpp','cxx','c++','c','cc','C']
	let l:hf=['hpp','hxx','h++','h','hh','H']

	let l:len=len(l:cf)
	let l:i=0
	while (l:i<l:len)
		if (l:sExt==l:cf[l:i])
			let l:sExt=l:hf[l:i]
		elseif (l:sExt==l:hf[l:i])
			let l:sExt=l:cf[l:i]
		else
			let l:i+=1
			continue
		endif

		let l:s=l:sFile.'.'.l:sExt
		"let l:s=findfile(l:s,l:sDir)
		"if (0==strlen(l:s))
		"	if ('hpp'==l:sExt)
		"		let l:s=l:sFile.'.h'
		"	elseif ('c'==l:sExt)
		"		let l:s=l:sFile.'.cpp'
		"	endif
		"	let l:s=findfile(l:s,l:sDir)
		"endif

		let l:s=findfile(l:s,l:sDir)
		if (0<strlen(s))
			let l:s=l:sDir.'\'.l:s
			exec 'silent! :tabedit '.l:s
			return
		endif
		break
	endwhile

		let l:s=browse('','Ë­¼ÒÐÂÑà×Ä´ºÄà',l:sDir,'')
		if (0<strlen(s))
			exec 'silent! :tabedit '.l:s
		endif
endfunction
