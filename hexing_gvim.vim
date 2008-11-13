"hexing's vim script
"source $VIM/hexing_gvim.vim

"../hexing_gvim.vim
"../vim71/colors/hexing_wuye.vim
"autoload/hexing/hexing_autoload.vim
"autoload/hexing/hexing_cpp.vim



"term settings {{{1
	colorscheme	hexing_wuye "source $VIMRUNTIME/colors/��ɽüwuye.vim

	set number ruler showcmd showmode "splitright
	set nospell nocompatible
	set incsearch hlsearch ignorecase

	set nowrap whichwrap=b,s	"���Զ����У�ֻ��<BS><SPACE>�������м����
	set scrolloff=8	scroll=16 sidescroll=9 sidescrolloff=18
	set textwidth=0 shiftwidth=4 tabstop=4 softtabstop=4
	set smartindent autoindent
	"set autoread
	"set cdpath path
	set completeopt=menuone
	set wildmode=full wildmenu wildchar=<Tab>
	set foldenable foldmethod=marker "foldnestmax=7 foldclose=all foldopen=all
	set diffopt+=vertical switchbuf=split
	set matchpairs+=<:>

	set winaltkeys=no viminfo= shortmess+=I	"����ʾ�������֣��˳�ʱ��������Ϣ
	set ambiwidth=double "bomb	"�����ֽ�˳�� ֻ��д���ʱ��Ż���Ч��������������Ч��
	set history=9 tabpagemax=96 undolevels=36
	set maxfuncdepth=97 more
	set selection=exclusive "inclusive
	set bufhidden=
	set grepprg=grep\ -nrHubE\ -e 
	set isfname+=32 "��gfҲ�ܲ��Ұ���space���ļ���

	syntax enable
	syntax on
	filetype plugin indent on

	set nobackup nowritebackup  updatecount=0 backupdir=	"�رձ��ݹ���
	set	directory=b:/temp/	"������.swp����ָ��Ŀ¼
	set noswapfile	"���ڱ༭�����н�ֹʹ�ý����ļ�


	"set title titlestring=%<%F%=%l/%L-%P titlelen=70
	"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
	"set title titlestring=ɽ�ᴺ��\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
	

	set showtabline=0	"ʼ����ʾ��ǩҳ
	"set guitablabel=%{tabpagenr()}.%t\ %m	"ÿ��tab����ʾ���
	"set iskeyword+=.	"��.Ҳ��Ϊ��word��һ���Ϸ��ַ�


	"scriptnames	"�г����м��ص� plugins, _vimrcs
	"verbose set history	"��ʾhistory��ֵ��ָ�������ļ���λ��

	"set laststatus=2	"������ʾ״̬��
	"if has("statusline")	"�Զ���״̬������ʾ����
	"set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P 
	"endif

"plugin settings {{{1
	"taglist.vim {{{2
		let g:Tlist_Exit_OnlyWindow = 1
		let g:Tlist_Show_One_File = 1
		let g:Tlist_Sort_Type = 'name'
		let g:Tlist_File_Fold_Auto_Close = 1
		let g:Tlist_Ctags_Cmd = $VIM . '/vimfiles/bin/ctags.exe'

	"matchparen.vim {{{2
		let g:loaded_matchparen = 0

	"autoclose.vim {{{2
		let g:autoclose_on = 1

"autocmd {{{1
		autocmd BufEnter * exec "cd %:p:h"
		"auto BufEnter * let &titlestring = hostname() . "/" . expand("%:p")
		

"maps {{{1 
	"normal mode {{{2
		nnoremap / :nohlsearch<CR>/
		nnoremap ? :nohlsearch<CR>?
		nnoremap <silent> <F5> :nohlsearch<CR>
		"nnoremap <Esc> :nohlsearch<CR><Esc>
		nnoremap <Home> ^
		"nnoremap <Home> 1_
		"nnoremap 0 ^
		map <kPoint> G
		nnoremap <silent> <kPlus> :set foldlevel-=1<CR>
		nnoremap <silent> <kMinus> :set foldlevel+=1<CR>
		nnoremap <C-F4> :call hexing#hexing_autoload#HX_close_buffer()<CR>
		"nnoremap <S-Y> y$
		nnoremap <silent> <F6> :call  hexing#hexing_autoload#HX_toggle_quickfix_wnd()<CR>

	"insert mode {{{2
		inoremap <CR> <C-R>=pumvisible() ? "\<lt>C-Y>" : "\<lt>CR>"<CR>
		inoremap <expr> <Esc> pumvisible() ? "\<C-E>" : "\<Esc>"
		inoremap <C-CR> <End><CR>
		inoremap <S-CR> <Up><End><CR>
		inoremap <Home> <C-O>^

		inoremap <A-o> <C-X><C-O>
		inoremap <A-u> <C-X><C-U>
		inoremap <A-p> <C-X><C-P>
		inoremap <A-n> <C-X><C-N>
		inoremap <A-l> <C-X><C-L>
		inoremap <A-k> <C-X><C-K>
		inoremap <A-v> <C-X><C-V>

	"visual mode {{{2
		vnoremap <silent> <A-F8> :call hexing#hexing_autoload#HX_align_lines()<CR>


"command {{{1
	command! -range Align : call hexing#hexing_autoload#HX_align_word_column(<line1>, <line2>)

"gui settings {{{1
	if has("gui_running")
		if has("win32")
			set guioptions-=T guioptions-=r guioptions-=l guioptions+=h guioptions-=m guioptions-=R
			if !&diff
				set guioptions-=b guioptions-=L
			else
				set guioptions+=b guioptions+=L
			endif
			autocmd GUIEnter * simalt ~x	"�趨 windows �� gvim ����ʱ���
			set guifont=Arial_monospaced_for_SAP:h11.8:w6.7
		endif
	endif
"}}}1
