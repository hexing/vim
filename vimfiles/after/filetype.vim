augroup filetypedetect
	au BufNewFile,BufRead *.txt	                    setf text
	au BufNewFile,BufRead *.log	                    setf text

	"���δ����file type
	au BufNewFile,BufRead *		                    setf unkown
augroup END
