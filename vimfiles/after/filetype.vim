augroup filetypedetect
	au BufNewFile,BufRead *.txt                     setf text

	"×îºóÎ´¼ì²â³öfile type
	au BufNewFile,BufRead *		                    setf unkown
augroup END
