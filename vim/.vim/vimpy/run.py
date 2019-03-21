import os 
import re
import vim
import time


filetype = vim.eval("&filetype")
filename = vim.eval('expand("%:t")')
no_ext   = vim.eval('expand("%:r")')
filepath = vim.eval('expand("%:p:r")')
commands = {
    "python" : "silent !python3 {}".format(filename),
    "bash"   : "silent !bash {}".format(filename),
    "sh"     : "silent !bash {}".format(filename),
    "cs"     : "silent !mono {}".format(no_ext),
    "arduino": "ArduinoUpload",
    "java"   : "silent !java {}".format(no_ext),
    "prolog" : "silent !swipl {}".format(filename),
    "make"   : "silent !make"
}


if vim.eval("g:clearrun") == "1":
    vim.command("silent !clear")

stime = time.time()
vim.command('silent !printf "Running {}\\n"'.format(filename))


run_command = "silent !" + filepath
if filetype in commands.keys():
    run_command = commands[filetype]

input_from_file = ""
if vim.eval("g:filein") == "1" and os.path.isfile(filepath + ".in"):
    input_from_file = " < {}.in".format(filepath)
    vim.command('silent !printf "Input from file-----\\n"')
    with open(filepath + ".in", 'r') as fin:
        for line in fin.readlines():
            to_backslash = "<>()[]{}\'\"*=;&$"
            for c in to_backslash:
                line = line.replace(c, '\\' + c)
            vim.command('silent !echo {}'.format(line))
    vim.command('silent !printf "Input end-----------\\n\\n"')

if os.path.isfile("./Makefile"):
    with open("./Makefile", 'r') as fin:
        fn = re.findall(r'^[a-zA-Z]+?:', fin.read(), flags=re.MULTILINE)[0][:-1]
    vim.command("silent !./{} {}".format(fn, input_from_file))
else:
    vim.command(run_command + input_from_file)


finish_time = time.time() - stime
vim.command('silent !printf "\\n--------------------\\n"')
vim.command('silent !printf "Finished in {0:.3f} s."'.format(finish_time))
vim.command('!echo ""') # To get "Press ENTER" prompt.

