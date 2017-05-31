import vim, re


def parse_ri(inp):
    inp = inp[1:-1]
    a, b = inp.split("..")
    return "ri({},{})".format(a, b)

def parse_array(inp):
    return "choice({})".format(inp)

def parse_rus(inp):
    rus = "уенваростх–×"
    eng = "yehbapoctx-*"
    for i in range(len(rus)):
        if inp.count(rus[i]):
            inp = inp.replace(rus[i], eng[i])
    return inp


randint_re = re.compile("/[0-9]+\.\.[0-9]+/")
array_re   = re.compile("\[.+\]")

ansline = ""
line = parse_rus(vim.eval("getline('.')").lower())
line = line.replace(" ", "")
elements = line.rstrip(";").split(";")
for el in elements:
    # Replacing Randint (/1..5/ -> ri(1, 5)
    for match in randint_re.findall(el):
        el = el.replace(match, parse_ri(match))

    # Replaceing arrays ([1, 2, 3] -> choice([1, 2, 3]))
    for match in array_re.findall(el):
        el = el.replace(match, parse_array(match))

    # Beautifying
    el = el.replace("*", " * ")
    el = el.replace(":", " / ")
    el = el.replace("-", " - ")
    el = el.replace("+", " + ")
    el = el.replace("=", " = ")
    el = el.replace(",", ", ")

    ansline += el + "\r"

curlinenum = int(vim.eval("line('.')"))
vim.command("call setline('.', '{}')".format(ansline))
vim.command("{}s/\r/\r/ge".format(curlinenum))

