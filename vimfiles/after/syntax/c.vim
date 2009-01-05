syntax region cBlock	matchgroup=Operator start="{" end="}" transparent fold
syntax region cBlock	start="#if" end="#endif" transparent fold

syn region	cDefine		start="^\s*\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" end=".[^"]*//.[^"]*"me=s-1 keepend contains=ALLBUT,@cPreProcGroup,@Spell
