augroup filetypedetect
	au BufNewFile,BufRead *.txt                     setf text

	"���δ����file type
	au BufNewFile,BufRead *		                    setf unkown
augroup END
