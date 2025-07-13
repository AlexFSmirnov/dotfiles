function Map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }

  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  local modes = type(mode) == "table" and mode or { mode }
  local lhs_list = type(lhs) == "table" and lhs or { lhs }

  for _, m in ipairs(modes) do
    for _, l in ipairs(lhs_list) do
      vim.keymap.set(m, l, rhs, options)
    end
  end
end

-- Remap space as leader key
Map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General mappings
Map("n", ";", ":", { silent = false })
Map("i", "jj", "<Esc>")
Map("c", "jj", "<C-c>")

Map("n", "<C-h>", "5zh")
Map("n", "<C-l>", "5zl")

Map("", "H", "^")
Map("", "L", "$")

Map("i", "<C-BS>", "<C-w>")
Map("c", "<C-BS>", "<C-w>", { silent = false })

