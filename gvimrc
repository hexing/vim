"set title titlestring=千里暮云平
"set title titlestring=%<%F%=%l/%L-%P titlelen=70
"set title titlestring=千里暮云平\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set title titlestring=千里暮云平\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
"set title titlestring=%<%F%=%l/%L-%P titlelen=70
"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
"set title titlestring=山横春烟\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

set showtabline=0	"始终显示标签页
"set guitablabel=%{tabpagenr()}.%t\ %m	"每个tab上显示编号

"set laststatus=2	"总是显示状态栏
"if has("statusline")	"自定义状态栏的显示内容
"set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P 
"endif

"auto BufEnter * let &titlestring = hostname() . "/" . expand("%:p")

if has("gui_running")
	if has("win32")
		set guioptions-=T guioptions-=r guioptions-=l guioptions+=h guioptions-=m guioptions-=R
		if !&diff
			set guioptions-=b guioptions-=L
		else
			set guioptions+=b guioptions+=L
		endif
		autocmd GUIEnter * simalt ~x	"设定 windows 下 gvim 启动时最大化
		"set guifont=Vera_Sans_YuanTi_Mono:h11.8:w6.7:b,Bitstream\ Vera\ Sans\ Mono:h11.8:w6.7:b,Arial_monospaced_for_SAP:h11.8:w6.7:b
	endif
endif
