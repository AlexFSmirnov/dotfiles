_G.tab_names = {}

function SetTabName(tabnr, name)
  _G.tab_names[tabnr] = name
end

function SetCurrentTabName(name)
  SetTabName(vim.fn.tabpagenr(), name)
end

function _G.tabline()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = vim.fn.tabpagebuflist(i)[winnr]
    local bufname = vim.fn.bufname(bufnr)
    local tabname = _G.tab_names[i] or (bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]")

    if i == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#" .. " " .. tabname .. " "
    else
      s = s .. "%#TabLine#" .. " " .. tabname .. " "
    end
  end
  s = s .. "%#TabLine#%T"

  return s
end

vim.o.tabline = "%!v:lua.tabline()"
