" Reload vimrc
map gr :sou ~/.vimrc<Enter>:echo "Reloaded .vimrc"<Enter>

" Syntax {
syntax enable
colorscheme default
highlight LineNr      ctermfg=darkgrey
highlight Comment     ctermfg=darkgrey
highlight String      ctermfg=darkyellow
highlight Statement   ctermfg=red
highlight Function    ctermfg=green
highlight Number      ctermfg=magenta
highlight Include     ctermfg=red
" }

" General options {
set nocompatible
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set number
set showcmd
set whichwrap+=h,l
set matchpairs+=<:>
set complete-=i
set hlsearch
set ruler
set wildmenu
set splitright
set splitbelow
set autoread
set undofile
set backspace=indent,eol,start
" }

autocmd BufEnter Makefile set noet
autocmd BufLeave Makefile set et

au BufRead,BufNewFile *.in setfiletype text
au BufEnter,BufRead,BufNewFile *.md setfiletype markdown

" General mappings {
imap jj <Esc>
map <C-J> 5j
map <C-K> 5k
" }

" Compilation functions {
func! CompileCPP()
    let $CXXFLAGS = "-O2 -std=c++11 -Wall -Wextra -DLOCAL "
    make! %:r
endf

func! Compile()
    :write
    if &filetype == "cpp"
        call CompileCPP()
    else
        echo "Not appropriate file type"
    endif
endf
" }

" Running functions {
func! RunPython()
    :!python3 %
endf
func! RunBash()
    :!bash %
endf

func! Run()
    :write
    :silent !printf "\n\nRunning %"
    if &filetype == "python"
        call RunPython()
    elseif &filetype == "sh" || &filetype == "bash"
        call RunBash()
    else
        :!%<
    endif
endf
" }

" Run/compile mappings {
map <F9> :call Compile()<Enter>
imap <F9> <Esc>:call Compile()<Enter>
map <F5> :call Run()<Enter>
imap <F5> <Esc>:call Run()<Enter>
" }

" TODO: rewrite (not like Vanya)
" Comments {
func! GetCommentString()
    let str = "#"
    if &filetype == "cpp" || &filetype == "c" || &filetype == "html" || &filetype == "java" || &filetype == "javascript"
        let str = "//"
    elseif &filetype == "vim"
        let str = "\""
    elseif &filetype == "tex"
        let str = "%"
    endif
    return str . " "
endf
func! AddComment()
    let str = GetCommentString()
    call setline(".", str . getline("."))
    let move_cnt = len(str)
    while move_cnt > 0
        normal l
        let move_cnt -= 1
    endwhile
endf
func! RemoveComment()
    " ISSUE: works bad on multiline comments and when line is a comment only
    " with no leading whitespace
    let str = GetCommentString()
    let old = getline(".")
    let new = substitute(old, "^" . str, "", "")
    if old == new
        let str = str[:-2]
        let new = substitute(old, "^" . str, "", "")
    endif
    let move_cnt = len(old) - len(new)
    while move_cnt > 0
"         normal h
        let move_cnt -= 1
    endwhile
    call setline(".", new)
endf
map gc :call AddComment()<Enter>
map gu :call RemoveComment()<Enter>

au FileType c,cpp setlocal comments-=:// comments+=f://
" }

" Folding {
map gz HV/{<Enter>%zf:let @/=""<Enter>
" }}

set timeoutlen=300

map L $
map H ^

nnoremap gp `[v`]
nnoremap gP `[V`]

iab uns using namespace std;

set list
set listchars=tab:>-

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
imap оо <Esc>
" for соответствие
inoremap соо соо
map Д $
map Р ^
cmap ц w
imap А А
imap с с

func! SubSwap(arg1, arg2, ...)
    if a:0 > 0 && a:1 == 1
        let S='%s/\V'
    else
        let S='%s/'
    endif

    exec S . a:arg1 . '/ADFLJWERFASDFWERWAFDASFEWR/g'
    exec S . a:arg2 . '/' . a:arg1 . '/g'
    exec S . 'ADFLJWERFASDFWERWAFDASFEWR/' . a:arg2 . '/g'
endf


" Adequate syntax hl when using vimdiff 
highlight DiffAdd    cterm=none ctermfg=10 ctermbg=4 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=none ctermfg=10 ctermbg=4 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=none ctermfg=10 ctermbg=4 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=none ctermfg=10 ctermbg=1 gui=none guifg=bg guibg=Red
func! DiffWithHead()
    echo expand('%')
    let relpath=system('git ls-tree --name-only --full-name HEAD ' . expand('%'))
    echo relpath
    vnew
    execute "normal V:!" . 'git cat-file blob HEAD:' . relpath
    windo diffthis
    wincmd w
endf

