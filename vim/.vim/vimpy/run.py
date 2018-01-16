import os 
import vim
import time


filetype = vim.eval("&filetype")
filename = vim.eval('expand("%:t")')
filepath = vim.eval('expand("%:p:r")')
commands = {
    "python": "python3 {}".format(filename),
    "bash"  : "bash {}".format(filename),
    "sh"    : "bash {}".format(filename),
}


if vim.eval("g:clearrun") == "1":
    vim.command("silent !clear")

stime = time.time()
vim.command('silent !printf "\\n\\nRunning {}\\n"'.format(filename))


run_command = filepath
if filetype in commands.keys():
    run_command = commands[filetype]

if vim.eval("g:filein") == "1" and os.path.isfile(filepath + ".in"):
    run_command += " < {}.in".format(filepath)
    vim.command('silent !printf "Input from file-----\\n"')
    with open(filepath + ".in", 'r') as fin:
        for line in fin.readlines():
            vim.command('silent !echo {}'.format(line))
    vim.command('silent !printf "Input end-----------\\n\\n"')

vim.command("silent !{}".format(run_command))


finish_time = time.time() - stime
vim.command('silent !printf "\\n--------------------\\n"')
vim.command('silent !printf "Finished in {0:.3f} s."'.format(finish_time))
vim.command('!echo ""') # To get "Press ENTER" prompt.

