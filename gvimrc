"set title titlestring=ǧ��ĺ��ƽ
"set title titlestring=%<%F%=%l/%L-%P titlelen=70
"set title titlestring=ǧ��ĺ��ƽ\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set title titlestring=ǧ��ĺ��ƽ\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
"set title titlestring=%<%F%=%l/%L-%P titlelen=70
"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
"set title titlestring=ɽ�ᴺ��\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

set showtabline=0	"ʼ����ʾ��ǩҳ
"set guitablabel=%{tabpagenr()}.%t\ %m	"ÿ��tab����ʾ���

"set laststatus=2	"������ʾ״̬��
"if has("statusline")	"�Զ���״̬������ʾ����
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
		autocmd GUIEnter * simalt ~x	"�趨 windows �� gvim ����ʱ���
		"set guifont=Vera_Sans_YuanTi_Mono:h11.8:w6.7:b,Bitstream\ Vera\ Sans\ Mono:h11.8:w6.7:b,Arial_monospaced_for_SAP:h11.8:w6.7:b
	endif
endif
