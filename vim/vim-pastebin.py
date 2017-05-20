import vim, requests, pyperclip


def get_range():
    buf = vim.current.buffer
    (lnum1, col1) = buf.mark('<')
    (lnum2, col2) = buf.mark('>')
    lines = vim.eval('getline({}, {})'.format(lnum1, lnum2))
    if len(lines) == 1:
        lines[0] = lines[0][col1:col2 + 1]
    else:
        lines[0] = lines[0][col1:]
        lines[-1] = lines[-1][:col2 + 1]
    return "\n".join(lines)


url = "https://pastebin.com/api/api_post.php"
try:
    user_dev_key = open("/home/alexfsmirnov/.pastebin_dev_key").read().strip()
except IOError:
    raise IOError("No pastebin dev key found")

r = requests.post(url, dict(
    api_option="paste",
    api_dev_key=user_dev_key,
    api_paste_code=get_range(),
    api_paste_private="1",
    api_paste_format=vim.eval("&filetype")))

vim.command("let cp = input('{}. Copy to clipboard? (y/N) ')".format(r.text))
cp = vim.eval("cp")
if cp.lower() == 'y':
    pyperclip.copy(r.text)
    print(" Copy success.")
