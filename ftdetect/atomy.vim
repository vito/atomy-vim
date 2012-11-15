set wildignore+=*.ayc

autocmd BufNewFile,BufRead *.ay set ft=atomy
autocmd BufNewFile,BufRead *.any set ft=anatomy
autocmd BufNewFile,BufRead *.ay,*.any
      \ setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
      \ commentstring=--\ %s nolisp autoindent indentexpr=GetAtomyIndent(v:lnum)
