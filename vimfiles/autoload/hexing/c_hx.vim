"functions {{{1
	"additional functions {{{2
		function!  hexing#c_hx#HX_make() "{{{3
			exec "silent! normal! :update\<CR>"
			exec "silent! normal! :make! --quiet\<CR>"
			if (0 == v:shell_error)
				exec "silent! normal! :cw\<CR>"
			else
				exec "silent! normal! :copen\<CR>"
			endif
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

			return "\<CR>"
		endfunction

		function!  hexing#c_hx#HX_keymap_Dkh() "{{{3
			let l:lCur = getline('.')
			let l:lPrev = getline(line('.')-1)

			if l:lCur =~ '=\s*$' || l:lPrev =~ '=\s*$'
				return "{};\<Left>\<Left>"
			endif

			let l:arr = ['\<class\>','\<struct\>','\<namespace\>']
			for m in l:arr
				if l:lCur =~ m || l:lPrev =~ m
					return "{\<CR>};\<Up>\<End>\<CR>"
				endif
			endfor

			let l:arr = ['\<if\>','\<for\>']
			for m in l:arr
				if l:lCur =~ m || l:lPrev =~ m
					return "{\<CR>}\<Up>\<End>\<CR>"
				endif
			endfor

			if l:lCur =~ '\<while\>' || l:lPrev =~ '\<while\>'
				return "{\<CR>break;\<CR>}\<Up>\<Up>\<End>\<CR>"
			endif

			if l:lCur =~ '\<do\>' || l:lPrev =~ '\<do\>'
				return "{\<CR>}while();\<Up>\<End>\<CR>"
			endif

			if l:lCur =~ 'switch\s*(.*)' || l:lPrev =~ 'switch\s*(.*)'
				return "{\<CR>};\<Up>\<End>\<CR>" . "case :\<CR>break;\<CR>" . "default:\<CR>break;" . "\<Up>\<Up>\<Up>\<Left>"
			endif

			return hexing#hexing_autoload#HX_paire('{')
		endfunction

		function!  hexing#c_hx#HX_keymap_Colon() "{{{3
			let l:lCur = getline('.')
			let l:lNxt = getline(line('.')+1)

			if l:lNxt !~ '\<break\>;'
				if l:lCur =~ '\<case\>\s\+$'
					return ":\<CR>break;\<Up>\<End>\<Left>"
				elseif l:lCur =~ '\<case\>$'
					return " :\<CR>break;\<Up>\<End>\<Left>"
				endif
			endif

			return ':'
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
