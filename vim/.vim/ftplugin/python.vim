setl nosmartindent

" Interactive shell with <F4>
map <F4> :!python3 -i %<Enter>
imap <F4> <Esc>:!python3 -i %<Enter>

" Custom highlights
syn keyword pythonSelf self
highlight def link pythonSelf Statement
