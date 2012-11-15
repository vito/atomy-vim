" Remove any old syntax stuff hanging around
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

syn include @AtomyBase syntax/atomy.vim

syn region anatomyBrackRange matchgroup=Delimiter start="\[" end="\]" contains=@AtomyBase contained nextgroup=anatomyBraceRange,anatomyBrackRange
syn region anatomyBraceRange matchgroup=Delimiter start="{" end="}" contains=anatomyExprStart,anatomyInnerBraceRange nextgroup=anatomyBrackRange,anatomyBraceRange contained
syn region anatomyInnerBraceRange matchgroup=anatomyBraceRange start="{" end="}" contains=anatomyExprStart,anatomyInnerBraceRange contained

syn region anatomyStringBrackRange matchgroup=Delimiter start="\[" end="\]" contains=@AtomyBase contained nextgroup=anatomyStringBraceRange,anatomyStringBrackRange
syn region anatomyStringBraceRange matchgroup=Delimiter start="{" end="}" contains=anatomyExprStart nextgroup=anatomyStringBrackRange,anatomyStringBraceRange contained

syn region anatomyAtomyBraceRange matchgroup=Delimiter start="{" end="}" contains=@AtomyBase nextgroup=anatomyBrackRange,anatomyBraceRange contained

syn match anatomyIdentifier /[a-zA-Z0-9\-_]\+/ nextgroup=anatomyBraceRange,anatomyBrackRange contained

syn match anatomyExprStart "\\" nextgroup=anatomyBrackRange,anatomyBraceRange,anatomyIdentifier,@AtomyBase containedin=anatomyBraceRange,anatomyInnerBraceRange,@AtomyBase

syn match anatomyMarkup "\\\(use\|title\)" nextgroup=anatomyStringBrackRange,anatomyStringBraceRange,anatomyIdentifier,@AtomyBase containedin=anatomyBraceRange,anatomyInnerBraceRange,anatomyStringBraceRange,@AtomyBase

syn match anatomyAtomy "\\\(hl\|example\|atomy\)" nextgroup=anatomyAtomyBraceRange,@AtomyBase containedin=anatomyBraceRange,anatomyInnerBraceRange,anatomyStringBraceRange,@AtomyBase

syn match anatomyLanguage "#language .*"

syn region anatomyBlockComment start="{-"  end="-}" contains=anatomyBlockComment



if version >= 508 || !exists("did_anatomy_syntax_inits")
  if version < 508
    let did_anatomy_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink anatomyBlockComment        anatomyComment
  HiLink anatomyComment             Comment

  HiLink anatomyLanguage            Comment

  HiLink anatomyStringBraceRange    String

  HiLink anatomyExprStart           Statement
  HiLink anatomyMarkup              Statement
  HiLink anatomyAtomy               Statement

  HiLink anatomyIdentifier          Statement

  delcommand HiLink
endif

let b:current_syntax = "anatomy"
