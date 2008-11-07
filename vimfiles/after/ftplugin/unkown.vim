"如果只打开一个txt文件"
let s:buf_name = bufname('#')
if (0 == bufexists(s:buf_name))
	setlocal guioptions+=m
	colorscheme random
endif
unlet s:buf_name
