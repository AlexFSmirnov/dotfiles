import vim, json, re


def paste_snippet(snippet):
    vim.command("call PasteSnippet('{}')".format(snippet))
    vim.command("redraw!")


filetype = vim.eval("&filetype")
input_ = vim.eval("snippet").split(' ')
input_snippet = input_[0].lower()
snippets_base = json.loads(open("/home/AlexFSmirnov/vim-snippets.json").read())

if input_snippet not in snippets_base.keys():
    print(" - not found.")
else:
    snippet = snippets_base[input_snippet]
    snippet_pasted = True
    
    # There are many texts for many filetypes in this snippet,
    # but user specified, which one he wants.
    if len(input_) > 1 and input_[1] in snippet.keys():
        selected_snippet = snippet[input_[1]]
    # Found a snippet for user filetype.
    elif filetype in snippet.keys():
        selected_snippet = snippet[filetype]
    # There is a universal text in this snippet.
    elif "any" in snippet.keys():
        selected_snippet = snippet["any"]
    # There is only one text for one filetype in this snippet,
    # but user wrote snippet codename in CAPS to force paste it.
    elif len(snippet.keys()) == 1 and input_snippet.upper() == input_[0]:
        selected_snippet = snippet.values()[0]
    else:
        if len(snippet.keys()) == 1:
            print(" - found one snippet for {}. ".format(snippet.keys()[0]) + 
                    "Write in CAPS to force paste.")
        else:
            print(" - found snippet for several other filetypes. " +
                    "Specify filetype to force paste.")
        snippet_pasted = False 

    if snippet_pasted:
        start_line = int(vim.eval("line('.')"))
        paste_snippet(selected_snippet)
        end_line = int(vim.eval("line('.')"))

        # Replacing ${1:templates} with user input.
        # If nothing was typed, ${1:default} value is used.
        template_re = re.compile("\${[0-9]+:.*?}")
        matches = list(sorted(set(template_re.findall(selected_snippet))))
        for match in matches:
            # sc_match - screened match. E.g. \ -> \\, * -> \*.
            sc_match = match.replace("/", "\\/").replace("*", "\\*")
            default = re.search(":(.*?)}", sc_match).group(1)
            vim.command("/\\" + sc_match)
            vim.command("redraw!")

            vim.command("call inputsave()")
            vim.command("let template_input = input('{} -> ')".format(match))
            vim.command("call inputrestore()")
            template_input = vim.eval("template_input")
            if template_input:
                vim.command("{},{}s/\\{}/{}/g".format(start_line, end_line,
                                                    sc_match, template_input))
            else:
                vim.command("{},{}s/\\{}/{}/g".format(start_line, end_line,
                                                    sc_match, default))

        # Placing cursor in ${x} position in snippet and emulating x
        # keypresses. E.g. if x = 'i', vim will go to insert mode.
        cursor_re = re.compile("\${[a-zA-Z]*}")
        match = cursor_re.findall(selected_snippet)
        if match:
            match = match[0]
            keys = re.search("\${([a-zA-Z]*)}", match).group(1)
            vim.command("{},{}s/\\{}/ ".format(start_line, end_line, match))
            vim.command("call feedkeys('{}')".format(keys))

