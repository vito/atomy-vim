autocmd BufNewFile,BufRead *.ay,*.eco set ft=atomy
autocmd BufNewFile,BufRead *.ddl set ft=tex
autocmd BufNewFile,BufRead *.ay,*.eco,*.ddl setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 commentstring=--\ %s
