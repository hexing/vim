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
	let s=expand('%')
	let s=substitute(s,'\.','_','g')
	let s=toupper(s)
	let s='__'.s.'__'
	call append(0,'#ifndef '.s)
	call append(1,'#define '.s)
	call append(2,'')
	call append(3,'')
	call append(4,'')
	call append(5,'')
	call append(line('$'),'#endif //'.s)
	call cursor(5,1)
endfunction


"key map functions {{{2
function!  hexing#c_hx#HX_keymap_Enter() "{{{3
	let line = getline('.')
	let len = strlen(line)
	let chPrev = line[col('.')-2]
	let chNext = line[col('.')-1]

	if '{'==chPrev
		if '}'==chNext
			return "\<CR>\<Up>\<End>\<CR>"
		elseif ''==chNext
			return "}\<Left>\<CR>\<Up>\<End>\<CR>"
		endif
	endif

	if  line =~ '#if.*'
		let lNxt = getline(line('.')+1)
		if lNxt !~ '#else.*' && lNxt !~ '#endif.*'
			return "\<CR>#endif\<Up>\<End>\<CR>"
		endif
	endif

	return "\<CR>"
endfunction

function!  hexing#c_hx#HX_keymap_Dkh() "{{{3
	let lCur = getline('.')
	let lPrev = getline(line('.')-1)

	let arr = ['=\s*$','\<enum\>']
	for m in arr
		if lCur =~ m || lPrev =~ m
			return "{};\<Left>\<Left>"
		endif
	endfor

	let arr = ['\<class\>','\<struct\>','\<namespace\>', '\<union\>']
	for m in arr
		if lCur =~ m || lPrev =~ m
			return "{\<CR>};\<Up>\<End>\<CR>"
		endif
	endfor

	let arr = ['\<if\>','\<for\>','else', 'elseif']
	for m in arr
		if lCur =~ m || lPrev =~ m
			return "{\<CR>}\<Up>\<End>\<CR>"
		endif
	endfor

	if lCur =~ '\<while\>' || lPrev =~ '\<while\>'
		return "{\<CR>break;\<CR>}\<Up>\<Up>\<End>\<CR>"
	endif

	if lCur =~ '\<do\>' || lPrev =~ '\<do\>'
		"return "{\<CR>} while ();\<Up>\<End>\<CR>"
		return "{\<CR>} while ();\<Left>\<Left>"
	endif

	if lCur =~ 'switch\s*(.*)' || lPrev =~ 'switch\s*(.*)'
		return "{\<CR>};\<Up>\<End>\<CR>" . "case 1:\<CR>break;\<CR>" . "default:\<CR>break;" . "\<Up>\<Up>\<Up>\<Left>\<BS>"
	endif

	return hexing#hexing_autoload#HX_paire('{')
endfunction

function!  hexing#c_hx#HX_keymap_Colon() "{{{3
	let lCur = getline('.')
	let lNxt = getline(line('.')+1)

	if lNxt !~ '\<break\>;'
		if lCur =~ '\<case\>\s\+$'
			return "1:\<CR>break;\<Up>\<End>\<Left>\<BS>"
		elseif lCur =~ '\<case\>$'
			return " 1:\<CR>break;\<Up>\<End>\<Left>\<BS>"
		endif
	endif

	return ':'
endfunction

function! hexing#c_hx#HX_keymap_Escape() "{{{3
	let lCur = getline('.')
	if lCur =~ '^\s*$'
		let lPre = getline(line('.')-1)
		"if lPre =~ '^\s*\(\/\*.*\*\/\s*\)*{\s*\(\/\*.*\*\/\s*\)*\(\/\/.*\)*$'
		if lPre =~ '{'
			let lNxt = getline(line('.')+1)
			"if lNxt =~ '^\s*\(\/\*.*\*\/\s*\)*}\s*\(\/\*.*\*\/\s*\)*\(\/\/.*\)*$'
			if lNxt =~ '}'
				return "\<Esc>dd"
			endif
		endif
	endif
	return "\<Esc>"
endfunction

"commentfunctions {{{2
function! hexing#c_hx#HX_comment_c() range "{{{3
	let vm = visualmode()

	if char2nr('v') == char2nr(vm)
		if a:firstline == a:lastline
			let s = getline(a:firstline)
			let s = strpart(s, 0, col("'>")-1) . '*/' . strpart(s, col("'>")-1)
			let s = strpart(s, 0, col("'<")-1) . '/*' . strpart(s, col("'<")-1) 
			call setline(a:firstline, s)
		else
			let ss = getline(a:firstline)
			let ss = strpart(ss, 0, col("'<")-1) . '/*' . strpart(ss, col("'<")-1)
			call setline(a:firstline, ss)
			let st = getline(a:lastline)
			let st = strpart(st, 0, col("'>")-1) . '*/' . strpart(st, col("'>")-1)
			call setline(a:lastline, st)
		endif
	elseif char2nr('V') == char2nr(vm)
		if a:firstline == a:lastline
			let ln = getline(a:firstline)
			let len = strlen(ln)
			let i = 0
			while i < len
				if ln[i] !~ '\s'
					break
				endif
				let i += 1
			endwhile
			let ln = strpart(ln, 0, i) . '/*' . strpart(ln, i, len-i)
			let ln = ln . '*/'
			call setline(a:firstline, ln)
		else
			let lb = getline(a:firstline)
			let len = strlen(lb)
			let i = 0
			while i < len
				if lb[i] !~ '\s'
					break
				endif
				let i += 1
			endwhile
			let lb = strpart(lb, 0, i) . '/*' . strpart(lb, i, len-i)

			let line = getline(a:lastline) . '*/'
			call setline(a:firstline, lb)
			call setline(a:lastline, line)
		endif
	endif
endfunction
