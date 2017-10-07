import vim, re, base64


current_line = vim.eval("getline('.')")
filename_re = re.compile("\".+?\..+?\"")
filenames = filename_re.findall(current_line)

for f in filenames:
    f = f[1:-1]
    ext = f[-3:]
    if ext not in ["png", "jpg", "bmp", "gif"]:
        continue
    try:
        with open(f, 'rb') as img_file:
            enc = base64.b64encode(img_file.read()).decode("utf8")
            enc = enc.replace("/", "\/")
        vim.command("s/{}/<img src='data:image\/{};base64,{}' \/>".format(f, ext, enc))
    except Exception as e:
        pass

