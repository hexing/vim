"hexing's vim script
"source $VIM/hexing_gvim.vim

"../hexing_gvim.vim
"../vim71/colors/hexing_wuye.vim
"autoload/hexing/hexing_autoload.vim
"autoload/hexing/hexing_cpp.vim



"term settings {{{1
	colorscheme	hexing_wuye "source $VIMRUNTIME/colors/春山眉wuye.vim

	set number ruler showcmd showmode "splitright
	set nospell nocompatible
	set incsearch hlsearch ignorecase

	set nowrap whichwrap=b,s	"不自动换行，只有<BS><SPACE>可以在行间回绕
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

	set winaltkeys=no viminfo= shortmess+=I	"不显示介绍文字，退出时不保存信息
	set ambiwidth=double "bomb	"设置字节顺序 只有写入的时候才会有效，现在设置是无效的
	set history=9 tabpagemax=96 undolevels=36
	set maxfuncdepth=97 more
	set selection=exclusive "inclusive
	set bufhidden=
	set grepprg=grep\ -nrHubE\ -e 
	set isfname+=32 "让gf也能查找包含space的文件名

	syntax enable
	syntax on
	filetype plugin indent on

	set nobackup nowritebackup  updatecount=0 backupdir=	"关闭备份功能
	set	directory=b:/temp/	"将所有.swp发入指定目录
	set noswapfile	"可在编辑过程中禁止使用交换文件


	"set title titlestring=%<%F%=%l/%L-%P titlelen=70
	"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
	"set title titlestring=山横春烟\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
	

	set showtabline=0	"始终显示标签页
	"set guitablabel=%{tabpagenr()}.%t\ %m	"每个tab上显示编号
	"set iskeyword+=.	"把.也认为是word的一个合法字符


	"scriptnames	"列出所有加载的 plugins, _vimrcs
	"verbose set history	"显示history的值并指出设置文件的位置

	"set laststatus=2	"总是显示状态栏
	"if has("statusline")	"自定义状态栏的显示内容
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
			autocmd GUIEnter * simalt ~x	"设定 windows 下 gvim 启动时最大化
			set guifont=Arial_monospaced_for_SAP:h11.8:w6.7
		endif
	endif
"}}}1
