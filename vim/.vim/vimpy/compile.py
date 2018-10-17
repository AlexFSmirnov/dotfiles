import vim
import time


def compile_cpp():
    flags = "-O2 -std=c++11 -Wall -Wextra -DLOCAL -fdiagnostics-color "
    if vim.eval("g:sfml") == "1":
        flags += "-lsfml-graphics -lsfml-window -lsfml-system "

    vim.command("!g++ {} {} -o {}".format(filename, flags, no_ext))

def compile_pascal():
    vim.command("silent !set -o pipefail")
    vim.command("!fpc -O3 % |& grep -v 'contains output sections'")

def compile_arduino():
    vim.command("ArduinoVerify")

def compile_cs():
    libs = ["/usr/lib/mono/gac/Mono.Cairo/4.0.0.0__0738eb9f132ed756/Mono.Cairo.dll",
            "/usr/lib/cli/gdk-sharp-2.0/gdk-sharp.dll",
            "/usr/lib/cli/glib-sharp-2.0/glib-sharp.dll",
            "/usr/lib/cli/gtk-sharp-2.0/gtk-sharp.dll",
            "/usr/lib/cli/atk-sharp-2.0/atk-sharp.dll"]
    vim.command("!mcs /reference:{} -out:%:r %".format(','.join(libs)))

def compile_java():
    vim.command("!javac {}".format(filename))


filetype = vim.eval("&filetype")
filename = vim.eval('expand("%")')
no_ext   = vim.eval('expand("%:r")')
if vim.eval("g:clearrun") == "1":
    vim.command("silent !clear")

vim.command('silent !printf "Compiling {}\\n"'.format(filename))

if filetype == "cpp":
    compile_cpp()
elif filetype == "pascal":
    compile_pascal()
elif filetype == "arduino":
    compile_arduino()
elif filetype == "cs":
    compile_cs()
elif filetype == "java":
    compile_java()
else:
    vim.command('echo "Not appropriate file type"')

