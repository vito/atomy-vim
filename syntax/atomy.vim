" Remove any old syntax stuff hanging around
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

" Delimiters
syn match atomyDelimiter   "(\|,"
syn match atomyBlock       ":\|;\|{\|}"

" Lists
syn region atomyList matchgroup=atomyArrayDelimiter
      \ start="\[" end="\]" contains=TOP

" Identifiers & Operators
syn match atomyIdentifier  "[a-z_][a-zA-Z0-9\-_]*"
syn match atomyOperator    ":\?[<>~!@#\$%\^&\*\-=\+./\?\\|]\+"

" Special Constants
syn keyword atomyNil         nil
syn keyword atomyBoolean     true false
syn keyword atomyConditional
      \ if then else when unless and or not otherwise while until
syn keyword atomyControl
      \ do for in return break next super loop rescue ensuring match bind
syn keyword atomySpecial     self

syn match atomyConditional "\<in?\>"

syn match atomySpecial
      \ "\<\(macro\|data\)\>("me=e-1

syn match atomyUse
      \ "\<\(use\)\>("me=e-1

syn match atomyRequire
      \ "\<\(require\)\>("me=e-1

syn match atomyExport
      \ "\<\(export\)\>("me=e-1

syn match atomyConditional
      \ "\<\(condition\)\>[[:space:]]*[:{]"me=e-1

syn match atomyControl
      \ "\<\(let\|with-restarts\|raise\|error\|warning\|signal\|restart\)\>("me=e-1
syn match atomyControl
      \ "\<\(open\|onto\|module\|class\|singleton\)\>[[:space:]]*[:{]"me=e-1

" Method Definition
syn match atomyMethod   contained "[a-z_][a-zA-Z0-9\-_]*[!?=]\?"
syn match atomyOpMethod contained ":\?[<>~!@#\$%\^&\*\-=\+./\?\\|]\+"
syn match atomyDefinition
      \ "[a-z_][a-zA-Z0-9\-_]*[!?=]\?[[:space:]]*:="me=e-2
      \ contains=atomyMethod,atomyGrouped,atomyOperator
syn match atomyDefinition
      \ "[a-z_][a-zA-Z0-9\-_]*[!?=]\?[[:space:]]*&.*:="me=e-2
      \ contains=atomyMethod,atomyGrouped,atomyOperator
syn match atomyDefinition
      \ "[a-z_][a-zA-Z0-9\-_]*[!?=]\?(.*:="me=e-2
      \ contains=atomyMethod,atomyGrouped,atomyOperator
syn match atomyDefinition
      \ "[[:space:]]\+:\?[<>~!@#\$%\^&\*\-=\+./\?\\|]\+[[:space:]]\+.*:="me=e-2
      \ contains=atomyOpMethod,atomyGrouped,atomyOperator

" Grouped
syn region atomyGrouped start="(" end=")" contains=TOP,atomyDefinition

" Strings
syn match atomyStringEscape contained
      \ "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match atomyStringEscape contained
      \ "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\)"
syn match atomyStringEscape contained
      \ "\\\(SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\)"
syn match atomyStringEscape contained
      \ "\\\(ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
syn match atomyStringEscapeError contained "\\&\|'''\+"
syn region atomyString
      \ matchgroup=atomyStringDelimiter start=+"+ skip=+\\\\\|\\"+ end=+"+
      \ contains=atomyStringEscape

" Numbers
syn match atomyNumber
      \ "\<[-+]\?[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>"
syn match atomyFloat
      \ "\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"

" Symbols &c.
syn match atomyUnquote     "\~\([a-z_][a-zA-Z\-_]*\)\?"
syn region atomyUnquote
      \ matchgroup=Special start="\~(" end=")" contains=TOP
syn match atomySplice      "\~\*\([a-z_][a-zA-Z\-_]*\)\?"
syn region atomySplice
      \ matchgroup=Special start="\~\*(" end=")" contains=TOP
syn match atomyQuasiQuote  "`"
syn region atomyQuasiQuote
      \ matchgroup=Special start="`(" end=")" contains=TOP
syn match atomyQuote       "'"
syn region atomyQuote
      \ matchgroup=Special start="'(" end=")" contains=TOP

" Interpolation (used in i"...", r"...", #"...")
syn region atomyInterpolation contained
      \ matchgroup=atomyInterpolationDelimiter start="#{" end="}"
      \ contains=TOP
syn region atomyNoInterpolation start="\\#{" end="}" contained
syn region atomyInterpolated    start=+i"+ skip=+\\\\\|\\"+ end=+"+
      \ contains=atomyInterpolation,atomyNoInterpolation,atomyStringEscape

" Particles
syn match atomyParticle
      \ "\.\([a-z_][a-zA-Z0-9\-_]*\|[A-Z][a-zA-Z0-9_]*\)[!?=]\?"
syn region atomyParticle start=+\."+  skip=+\\\\\|\\"+  end=+"+
      \ contains=atomyInterpolation,atomyNoInterpolation,atomyStringEscape

" Identifiers, Constants & Variables
syn match atomyConstant         "[A-Z][a-zA-Z0-9_]*"
syn match atomyClassVariable    "@@[a-z_][a-zA-Z0-9\-_]\+[!?=]\?"
syn match atomyInstanceVariable "@[a-z_][a-zA-Z0-9\-_]*[!?=]\?"
syn match atomyGlobalVariable   "$[a-z_][a-zA-Z0-9\-_]*[!?=]\?"

" Comments
syn match atomyLineComment   "--.*$"
syn region atomyBlockComment start="{-"  end="-}" contains=atomyBlockComment

" Regexp fun, ported from the Ruby syntax
syn region atomyRegexpComment   contained
      \ matchgroup=atomyRegexpSpecial start="(?#" skip="\\)" end=")"
syn region atomyRegexpParens    contained transparent
      \ matchgroup=atomyRegexpSpecial
      \ start="(\(?:\|?<\=[=!]\|?>\|?<[a-z_]\w*>\|?[imx]*-[imx]*:\=\|\%(?#\)\@!\)"
      \ skip="\\)" end=")" contains=@atomyRegexpSpecial
syn region atomyRegexpBrackets  contained transparent oneline
      \ matchgroup=atomyRegexpCharClass start="\[\^\=" skip="\\\]" end="\]"
      \ contains=atomyStringEscape,atomyRegexpEscape,atomyRegexpCharClass
syn match atomyRegexpCharClass  contained
      \ "\[:\^\=\%(alnum\|alpha\|ascii\|blank\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|xdigit\):\]"
syn match atomyRegexpCharClass  contained display "\\[DdHhSsWw]"
syn match atomyRegexpEscape     contained         "\\[].*?+^$|\\/(){}[]"
syn match atomyRegexpQuantifier contained display "[*?+][?+]\="
syn match atomyRegexpQuantifier contained display "{\d\+\%(,\d*\)\=}?\="
syn match atomyRegexpAnchor     contained display "[$^]\|\\[ABbGZz]"
syn match atomyRegexpDot        contained display "\."
syn match atomyRegexpSpecial    contained display "|"
syn match atomyRegexpSpecial    contained display "\\[1-9]\d\=\d\@!"
syn match atomyRegexpSpecial    contained display
      \ "\\k<\%([a-z_]\w*\|-\=\d\+\)\%([+-]\d\+\)\=>"
syn match atomyRegexpSpecial    contained display
      \ "\\k'\%([a-z_]\w*\|-\=\d\+\)\%([+-]\d\+\)\='"
syn match atomyRegexpSpecial    contained display "\\g<\%([a-z_]\w*\|-\=\d\+\)>"
syn match atomyRegexpSpecial    contained display "\\g'\%([a-z_]\w*\|-\=\d\+\)'"
syn cluster atomyRegexpSpecial
      \ contains=atomyInterpolation,atomyNoInterpolation,atomyStringEscape,atomyRegexpSpecial,atomyRegexpEscape,atomyRegexpBrackets,atomyRegexpCharClass,atomyRegexpDot,atomyRegexpQuantifier,atomyRegexpAnchor,atomyRegexpParens,atomyRegexpComment
syn region atomyRegexp          start=+r"+  skip=+\\\\\|\\"+  end=+"+
      \ contains=@atomyRegexpSpecial keepend



if version >= 508 || !exists("did_atomy_syntax_inits")
  if version < 508
    let did_atomy_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink atomyBlockComment        atomyComment
  HiLink atomyLineComment         atomyComment
  HiLink atomyComment             Comment
  HiLink atomySpecial             PreProc
  HiLink atomyConditional         Conditional
  HiLink atomyNumber              Number
  HiLink atomyFloat               Float
  HiLink atomyConditional         Conditional
  HiLink atomyNil                 Constant
  HiLink atomyBoolean             Boolean

  HiLink atomyStringEscape        SpecialChar
  HiLink atomyInterpolationDelimiter Delimiter
  HiLink atomyNoInterpolation     atomyString
  HiLink atomyStringEscapeError   Error
  HiLink atomyStringDelimiter     Delimiter
  HiLink atomyInterpolated        atomyString
  HiLink atomyString              String

  HiLink atomyRegexpEscape        atomyRegexpSpecial
  HiLink atomyRegexpQuantifier    atomyRegexpSpecial
  HiLink atomyRegexpAnchor        atomyRegexpSpecial
  HiLink atomyRegexpDot           atomyRegexpCharClass
  HiLink atomyRegexpCharClass     atomyRegexpSpecial
  HiLink atomyRegexpSpecial       Special
  HiLink atomyRegexpComment       Comment
  HiLink atomyRegexp              atomyString

  HiLink atomyConstant            Type
  HiLink atomyGlobalVariable      Identifier
  HiLink atomyClassVariable       Identifier
  HiLink atomyInstanceVariable    Identifier

  HiLink atomyOperator            Operator

  HiLink atomyQuasiQuote          PreProc
  HiLink atomyQuote               Special
  HiLink atomyUnquote             Special
  HiLink atomySplice              Special

  HiLink atomyMethod              Function
  HiLink atomyOpMethod            Function

  HiLink atomyParticle            Constant

  HiLink atomyUse                 Include
  HiLink atomyRequire             Include

  delcommand HiLink
endif

let b:current_syntax = "atomy"
