syntax region cBlock	matchgroup=Operator start="{" end="}" transparent fold
syntax region cBlock	start="#if" end="#endif" transparent fold

hi Include		gui=ITALIC guifg=#8A2BE2 guibg=bg		cterm=NONE ctermfg=lightmagenta ctermbg=black
hi Define		gui=ITALIC guifg=#8470FF guibg=bg		cterm=NONE ctermfg=lightmagenta ctermbg=black

""hi link cIncluded	Include
hi link cDefine		Define
