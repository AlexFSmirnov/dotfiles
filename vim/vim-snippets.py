import vim, json


def paste_snippet(snippet):
    vim.command("call PasteSnippet('{}')".format(snippet))


filetype = vim.eval("&filetype")
input_ = vim.eval("snippet").split(' ')
input_snippet = input_[0].lower()
snippets = json.loads(open("/home/AlexFSmirnov/.vim-snippets").read())

if input_snippet not in snippets.keys():
    paste_snippet("Snippet not found")
else:
    snippet = snippets[input_snippet]

    # Found a snippet for user filetype.
    if filetype in snippet.keys():
        paste_snippet(snippet[filetype])
    # There is a universal text in this snippet.
    elif "any" in snippet.keys():
        paste_snippet(snippet["any"])
    # There are many texts for many filetypes in this snippet,
    # but user specified, which one he wants.
    elif len(input_) > 1 and input_[1] in snippet.keys():
        paste_snippet(snippet[input_[1]])
    # There is only one text for one filetype in this snippet,
    # but user wrote snippet codename in CAPS to force paste it.
    elif len(snippet.keys()) == 1 and input_snippet.upper() == input_[0]:
        paste_snippet(snippet.values()[0])
    else:
        if len(snippet.keys()) == 1:
            print(" - found snippet for {}. ".format(snippet.keys()[0]) + 
                    "Write in CAPS to force paste.")
        else:
            print(" - found snippet for several other filetypes. " +
                    "Specify filetype to force paste.")



