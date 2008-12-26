"set title titlestring=千里暮云平
"set title titlestring=%<%F%=%l/%L-%P titlelen=70
"set title titlestring=千里暮云平\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
"auto BufEnter * let &titlestring = hostname() . "/" . expand("%:p")
set title titlestring=千里暮云平\ %t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)

"set tags+=E:/develop/tags/tags_core_libs
"set tags+=E:/develop/tags/tags_wxWidgets_include
"set tags+=E:/develop/tags/tags_wxWidgets_msw 
