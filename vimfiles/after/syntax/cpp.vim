" Read the C syntax to start with
"if version < 600
"  so <sfile>:p:h/c.vim
"else
"  runtime! syntax/c.vim
"  unlet b:current_syntax
"endif


syntax keyword cppExtention	__super
syntax keyword Keyword		tstring TCHAR
syntax keyword Special		NULL

syn match cOperator	'[.,:;&!~^|<>?=*+%()\[\]\-]'
syn match cOperator	'[/*]\@<!/[/*]\@!'

syntax region cppString	start=+_T\=("+ skip=+\\\\\|\\"+ end=+")+


" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
	if version < 508
		command -nargs=+ HiLink hi link <args>
	else
		command! -nargs=+ HiLink hi def link <args>
	endif

	HiLink cppExtention		Statement
	HiLink cppString		String
	HiLink cppCharacter		Character
	HiLink cOperator		Operator 

	delcommand HiLink
endif

hi cppAccess gui=UNDERCURL guifg=#00A600 guibg=bg		cterm=UNDERCURL ctermfg=lightgreen ctermbg=black
