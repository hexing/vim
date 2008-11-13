" OmniCppComplete initialization
call omni#cpp#complete#Init()

"setting {{{1
	"setlocal completefunc=hexing#hexing_autoload#HX_cpp_user_complete
	setlocal autoread 
	setlocal cinoptions+=)6 cinoptions+=:0 cinoptions+=(0 cinoptions+=g0 cinoptions-=:0
	setlocal complete=. complete+=t
	setlocal foldmethod=syntax foldlevel=9
	setlocal makeprg=make
	setlocal formatoptions-=r formatoptions-=o

	setlocal foldtext=CppFoldText()
	function! CppFoldText()
		return (v:foldstart - v:foldend) . ' lines foldlevel: ' . v:foldlevel . ' ' . getline(v:foldstart)
	endfunction
"map {{{1
	"inoremap <buffer> <silent> { {}<Left><CR><Up><End><CR>
	"inoremap <buffer> <silent> [ []<Left>
	inoremap <buffer> <silent> <CR> <C-R>=pumvisible() ? "\<lt>C-Y>\<lt>C-R>=hexing#hexing_autoload#HX_setion_complete()\<lt>CR>" : "\<lt>CR>"<CR>
	inoremap <buffer> <silent> <A-u> <C-R>=hexing#hexing_autoload#HX_popup_setion_completion('*')<CR>
	inoremap <buffer> <silent> <F7> <Esc>:update <Bar> make!<CR>

	nnoremap <buffer> <silent> <F7> :update <Bar> make!<CR>
	nnoremap <buffer> <silent> <F3> :AT<CR>
	nnoremap <buffer> <silent> <F8> :TlistToggle<CR>
	nnoremap <buffer> <silent> <A-t> :tnext<CR>

	vnoremap <buffer> <silent> <kDivide><kMultiply> :call hexing#hexing_autoload#HX_comment_c()<CR>

"iabbr {{{1
	"iabbr <buffer> <silent>  if if ()<Left>
	iabbr <buffer> <silent>  { {<CR>}<Up><End><CR>
	iabbr <buffer> <silent>  #i #include
	iabbr <buffer> <silent>  #d #define
	iabbr <buffer> <silent>  #f #ifdef<CR>#endif<Up><End>
	iabbr <buffer> <silent>  #n #ifndef<CR>#endif<Up><End>
	iabbr <buffer> <silent> tchar TCHAR
	inorea <buffer> <silent>  _ _("")<Left><Left>
	inorea <buffer> <silent>  _T _T("")<Left><Left>
	"iabbr <buffer> <silent>  ' _T('')<Left><Left>
	"iabbr <buffer> <silent>  { {<CR>}<Up><End><CR>
	"iabbr <buffer> <silent>  typ typedef

"Popup menu {{{1
	nnoremenu 0.01 PopUp.Cpp/H :AT<CR>
	nnoremenu 0.02 PopUp.TlistToggle :TlistToggle<CR>
	nnoremenu 0.09 PopUp.-SEP0-	<Nop>
