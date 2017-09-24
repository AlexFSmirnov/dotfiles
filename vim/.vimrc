" Reload vimrc
map gr :sou ~/.vimrc<Enter>:echo "Reloaded .vimrc"<Enter>

let g:leaderkey='\'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" Colorscheme {
syntax enable
colorscheme default
set t_Co=256
highlight LineNr        ctermfg=grey
highlight Comment       ctermfg=darkgrey
highlight String        ctermfg=yellow
highlight Statement     ctermfg=red
highlight Function      ctermfg=green
highlight Number        ctermfg=magenta
highlight Include       ctermfg=red
highlight Search        ctermfg=white     ctermbg=green
highlight MyColorC      ctermfg=238       ctermbg=grey     cterm=bold
highlight VertSplit     ctermfg=cyan      ctermbg=238      cterm=NONE
highlight StatusLine    ctermfg=cyan      ctermbg=238      cterm=bold
highlight StatusLineNC  ctermfg=white     ctermbg=238      cterm=NONE
highlight TabLine       ctermfg=white     ctermbg=238      cterm=NONE
highlight TabLineSel    ctermfg=cyan      ctermbg=233      cterm=bold
highlight TabLineFill   ctermfg=238
highlight Folded        ctermfg=cyan      ctermbg=darkgrey
highlight Pmenu         ctermfg=grey      ctermbg=black
highlight PmenuSel      ctermfg=cyan      ctermbg=black    cterm=bold
highlight MatchParen    ctermfg=cyan      ctermbg=darkgrey
highlight Visual        ctermbg=238
" }

" Vundle stuff (:PluginInstall to install plugins) {
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'mbbill/undotree'
Plugin 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'vim-latex/vim-latex'
Plugin 'wesQ3/vim-windowswap'
Plugin 'pangloss/vim-javascript'

call vundle#end()
filetype plugin indent on
" }

" General options {
set nowrap
set autoindent
set autoread
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
set nopaste
set mouse=a
" }

match MyColorC /\%<81v.\%>80v/

" Backup files
set directory=~/.vim/swapfiles//
set backupdir=~/.vim/backups//
set undodir=~/.vim/undodir//
 
autocmd BufEnter Makefile set noet
autocmd BufLeave Makefile set et
au! FileType python setl nosmartindent

au BufRead,BufNewFile *.in setfiletype text
au BufEnter,BufRead,BufNewFile *.md setfiletype markdown

" General mappings {
imap jj <Esc>
map <C-j> 5j
map <C-k> 5k
vmap cc <Esc>
map ; :
map <F6> :NERDTreeTabsClose <Enter> :UndotreeToggle <Enter>
map <F8> :UndotreeHide <Enter> :NERDTreeTabsToggle <Enter>
" }

" Function for smart copying and pasting 
func! SmartCopypaste()
    if &paste
        echo "Copypaste mode OFF"
        set nopaste 
        set number
    else
        echo "Copypaste mode ON"
        set paste
        set nonumber
    endif
endf
nmap <F2> :call SmartCopypaste() <Enter>
imap <F2> <Esc> :call SmartCopypaste() <Enter>

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
func! RunIPython()
    :!python3 -i %
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
map <F4> :call RunIPython()<Enter>
imap <F4> <Esc>:call RunIPython()<Enter>
map <F5> :call Run()<Enter>
imap <F5> <Esc>:call Run()<Enter>
" }

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
map zz HV/{<Enter>%zf:let @/=""<Enter>
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

func! DiffWithLastSave()
    :w !cat > /tmp/tempFile && vimdiff % /tmp/tempFile && rm /tmp/tempFile
endf

" Snippets { 
func! InputSnippet()
    call inputsave()
    let snippet = input('Enter snippet: ')
    call inputrestore()
    
    py3file ~/.vimpy/vim-snippets.py
endf

func! PasteSnippet(text)
    call setline('.', getline('.') . a:text)
    s//\r/ge
endf

" Removes newlines and screens brackets and '\'.
func! Snippify()
    '<,'>s/'/''/ge
    '<,'>s/\\/\\\\/ge
    '<,'>s/"/\\"/ge
    '<,'>s/\n/\\r/ge
    noh
endf

map <F3> :call InputSnippet() <Enter>
vmap <F3> :<BS><BS><BS><BS><BS>call Snippify() <Enter>
" }

" Paste to pastebin {
func! PasteToPastebin()
    py3file ~/.vimpy/vim-pastebin.py
endf
vmap <F10> :<BS><BS><BS><BS><BS>call PasteToPastebin() <Enter>
" }

" Parse FB TZ to python. {
func! ParseFB() 
    py3file ~/.vimpy/parsefb.py
endf
" }

" Transform image file from current line to Base64. {
func! ImageToBase64() 
    py3file ~/.vimpy/vim-im2b64.py
endf
" }
