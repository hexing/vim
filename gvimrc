"set title titlestring=ǧ��ĺ��ƽ
"set title titlestring=%<%F%=%l/%L-%P titlelen=70
"set title titlestring=ǧ��ĺ��ƽ\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
"auto BufEnter * let &titlestring = hostname() . "/" . expand("%:p")
set title titlestring=ǧ��ĺ��ƽ\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

"set tags+=E:/develop/tags/tags_core_libs
"set tags+=E:/develop/tags/tags_wxWidgets_include
"set tags+=E:/develop/tags/tags_wxWidgets_msw 
