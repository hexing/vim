"hexing's vim script
"source $VIM/hexing_gvim.vim

"../hexing_gvim.vim
"../vim71/colors/hexing_wuye.vim
"autoload/hexing/hexing_autoload.vim
"autoload/hexing/hexing_cpp.vim

"ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -f tag01 E:\develop\Core_Libs

"term settings {{{1
	colorscheme	hexing_wuye "source $VIMRUNTIME/colors/��ɽüwuye.vim

	set number ruler showcmd showmode "splitright
	set nospell nocompatible
	set incsearch hlsearch ignorecase
	set shortmess=oOtTI

	set nowrap whichwrap=b,s	"���Զ����У�ֻ��<BS><SPACE>�������м����
	set scrolloff=0	scroll=0 sidescroll=1 sidescrolloff=0
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

	"set tags+=E:/develop/tags/tags_core_libs
	"set tags+=E:/develop/tags/tags_wxWidgets_include
	"set tags+=E:/develop/tags/tags_wxWidgets_msw 

	"set iskeyword+=.	"��.Ҳ��Ϊ��word��һ���Ϸ��ַ�

	"scriptnames	"�г����м��ص� plugins, _vimrcs
	"verbose set history	"��ʾhistory��ֵ��ָ�������ļ���λ��


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

	"hx
		let g:TagDirectory = 'b:/tags'
		call hexing#hexing_autoload#HX_LoadTagFiles(g:TagDirectory)

"autocmd {{{1
		set autochdir "autocmd BufEnter * exec "cd %:p:h"
		"auto BufEnter * let &titlestring = hostname() . "/" . expand("%:p")
		

"maps {{{1 
	"normal mode {{{2
		nnoremap / :nohlsearch<CR>/
		nnoremap ? :nohlsearch<CR>?
		nnoremap <silent> <F5> :nohlsearch<CR>
		"nnoremap <Esc> :nohlsearch<CR><Esc>
		nnoremap Y y$
		nnoremap <Home> ^
		"nnoremap <Home> 1_
		"nnoremap 0 ^
		nnoremap <silent> <kPlus> :set foldlevel-=1<CR>
		nnoremap <silent> <kMinus> :set foldlevel+=1<CR>
		nnoremap <C-F4> :call hexing#hexing_autoload#HX_close_buffer()<CR>
		"nnoremap <S-Y> y$
		nnoremap <silent> <F6> :call  hexing#hexing_autoload#HX_toggle_quickfix_wnd()<CR>
		nnoremap <silent> <C-F12> :call hexing#hexing_autoload#HX_CreateTagFile()<CR>
		nnoremap <silent> <A-F12> :call hexing#hexing_autoload#HX_LoadTagFiles('')<CR>

	"insert mode {{{2
		inoremap <CR> <C-R>=pumvisible() ? "\<lt>C-Y>" : "\<lt>CR>"<CR>
		inoremap <expr> <Esc> pumvisible() ? "\<C-E>" : "\<Esc>"
		imap <C-CR> <End><CR>
		inoremap <S-CR> <C-O>O
		inoremap <Home> <C-O>^

		inoremap <A-o> <C-X><C-O>
		inoremap <A-u> <C-X><C-U>
		inoremap <A-p> <C-X><C-P>
		inoremap <A-n> <C-X><C-N>
		inoremap <A-l> <C-X><C-L>
		inoremap <A-k> <C-X><C-K>
		inoremap <A-v> <C-X><C-V>

		inoremap [ <C-R>=hexing#hexing_autoload#HX_paire('[')<CR>
		inoremap ] <C-R>=hexing#hexing_autoload#HX_paire(']')<CR>
		inoremap ( <C-R>=hexing#hexing_autoload#HX_paire('(')<CR>
		inoremap ) <C-R>=hexing#hexing_autoload#HX_paire(')')<CR>
		inoremap } <C-R>=hexing#hexing_autoload#HX_paire('}')<CR>
		inoremap ' <C-R>=hexing#hexing_autoload#HX_paire("'")<CR>

	"visual mode {{{2
		vnoremap <silent> <A-F8> :call hexing#hexing_autoload#HX_align_lines()<CR>

	"map
		map <kPoint> G


"command {{{1
	command! -range Align : call hexing#hexing_autoload#HX_align_word_column(<line1>, <line2>)
"}}}1
