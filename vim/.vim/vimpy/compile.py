import vim
import time


def compile_cpp():
    vim.command('let $CXXFLAGS = "-O2 -std=c++11 -Wall -Wextra -DLOCAL -fdiagnostics-color "')
    vim.command("make! %:r")

def compile_pascal():
    vim.command("silent !set -o pipefail")
    vim.command("!fpc -O3 % |& grep -v 'contains output sections'")

def compile_arduino():
    vim.command("ArduinoVerify")


filetype = vim.eval("&filetype")
if vim.eval("g:clearrun") == "1":
    vim.command("silent !clear")

if filetype == "cpp":
    compile_cpp()
elif filetype == "pascal":
    compile_pascal()
elif filetype == "arduino":
    compile_arduino()
else:
    vim.command('echo "Not appropriate file type"')

