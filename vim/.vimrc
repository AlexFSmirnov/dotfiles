" Reload vimrc
map gr :sou ~/.vimrc<Enter>:echo "Reloaded .vimrc"<Enter>

" Config {
let g:clearrun = 1  " Clear screen before each run
let g:filein   = 1  " Use file input if possible
let g:sfml     = 0  " Include SFML lib when compiling C++
" }

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
highlight Search        ctermfg=darkgrey  ctermbg=cyan     cterm=bold
highlight MyColorC      ctermfg=238       ctermbg=grey     cterm=bold
highlight VertSplit     ctermfg=cyan      ctermbg=238      cterm=NONE
highlight StatusLine    ctermfg=cyan      ctermbg=238      cterm=bold
highlight StatusLineNC  ctermfg=white     ctermbg=238      cterm=NONE
highlight TabLine       ctermfg=white     ctermbg=238      cterm=NONE
highlight TabLineSel    ctermfg=cyan      ctermbg=233      cterm=bold
highlight TabLineFill   ctermfg=238
highlight Folded        ctermfg=cyan      ctermbg=233
highlight Pmenu         ctermfg=grey      ctermbg=black
highlight PmenuSel      ctermfg=cyan      ctermbg=black    cterm=bold
highlight MatchParen    ctermfg=cyan      ctermbg=darkgrey
highlight Visual        ctermbg=238
highlight SpellBad      ctermfg=red       ctermbg=233
highlight SpellCap      ctermfg=cyan      ctermbg=233

match MyColorC /\%<81v.\%>80v/
" }

" Vundle stuff (:PluginInstall to install plugins) {
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'jiangmiao/auto-pairs'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'mbbill/undotree'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'vim-latex/vim-latex'
Plugin 'wesQ3/vim-windowswap'
Plugin 'pangloss/vim-javascript'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'google/vim-searchindex'
Plugin 'stevearc/vim-arduino'
Plugin 'sudar/vim-arduino-syntax'

call vundle#end()
filetype plugin indent on
" }

" Plugin settings {
let g:leaderkey='\'

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

let g:UltiSnipsExpandTrigger="<c-d>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/mysnippets"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

map gc :call NERDComment(0, "toggle")<Enter>
map gu :call NERDComment(0, "uncomment")<Enter>
"}

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
set spelllang=en_us,ru_ru
" }

" Backup files directories {
set directory=~/.vim/swapfiles//
set backupdir=~/.vim/backups//
set undodir=~/.vim/undodir//
" }
 
" Filetype-specific settings {
autocmd BufEnter Makefile set noet
autocmd BufLeave Makefile set et
au! FileType text   set spell

au BufRead,BufNewFile *.in setfiletype text
au BufEnter,BufRead,BufNewFile *.md setfiletype markdown
" }

" Folding {
nmap zz HV/{<Enter>%zf:let @/=""<Enter>
nmap zt za
vmap zz zf

" Save folds 
augroup AutoSaveFolds
    autocmd!
    autocmd BufWinLeave ?* mkview
    autocmd BufWinEnter ?* silent loadview
augroup END
" }

" General mappings {
imap jj <Esc>
cmap jj <C-c>
vmap vv <Esc>
" <C-j> is mapped by the UltiSnips, so we re-map it after the plugin is loaded
autocmd VimEnter * nnoremap <C-j> <C-e>
autocmd VimEnter * nnoremap <C-k> <C-y>
map ; :
map <F6> :NERDTreeTabsClose <Enter> :UndotreeToggle <Enter>
map <F8> :UndotreeHide <Enter> :NERDTreeTabsToggle <Enter>
vmap <C-y> "+y
nmap <C-p> "+p
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

" Running and compilation {
func! Compile()
    :write
    py3file ~/.vim/vimpy/compile.py
endf

func! Run()
    :write
    py3file ~/.vim/vimpy/run.py
endf
" }

" Run/compile mappings {
map <F9> :call Compile()<Enter>
imap <F9> <Esc>:call Compile()<Enter>
map <F5> :call Run()<Enter>
imap <F5> <Esc>:call Run()<Enter>
" }

set timeoutlen=300

map L $
map H ^

nnoremap gp `[v`]
nnoremap gP `[V`]

set list
set listchars=tab:>-

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
imap оо <Esc>
cmap оо <C-c>
" for соответствие, вообще, кооперация, зоопарк and so on.
inoremap соо соо
inoremap воо воо
inoremap коо коо
inoremap зоо зоо
map Д $
map Р ^
cmap ц w
cmap й q
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

" Paste to pastebin {
func! PasteToPastebin()
    py3file ~/.vim/vimpy/vim-pastebin.py
endf
vmap <F10> :<BS><BS><BS><BS><BS>call PasteToPastebin() <Enter>
" }

" Transform image file from current line to Base64. {
func! ImageToBase64() 
    py3file ~/.vim/vimpy/vim-im2b64.py
endf
" }
