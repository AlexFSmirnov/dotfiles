-- remove statuscolumn from nvim-tree
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "NvimTree" or vim.bo.filetype == "DiffviewFiles" then
      vim.opt_local.statuscolumn = ""
    end
  end,
})

-- terminal ui
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.statuscolumn = ""
  end,
})

-- terminal autoscroll
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  command = "startinsert | autocmd CursorHoldI term://* normal! G",
})
vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*",
  command = "if &buftype == 'terminal' | bd! | endif",
})

-- remember last position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",

  callback = function()
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})
