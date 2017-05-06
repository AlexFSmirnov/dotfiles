func! GetSnippetText(snippet)
    let g:text = 'Snippet not found'
    if &filetype == 'javascript'
        if a:snippet == 'randint'
            let g:text = "
            \function randint(min, max) {\r
            \    return Math.floor(Math.random() * (max - min + 1)) + min;\r
            \}"
        elseif a:snippet == 'test'
            let g:text = "
            \this is a single line"
        endif
    endif

    return g:text
endf
