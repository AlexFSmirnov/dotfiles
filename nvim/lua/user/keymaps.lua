local function keymap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }

  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Remap space as leader key
keymap('', '<Space', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Reload configuration
keymap('n', '<leader>r', ':so %<CR>', { desc = 'Reload config' })

-- General mappings
keymap('n', ';', ':', { silent = false })
keymap('i', 'jj', '<Esc>')
keymap('c', 'jj', '<C-c>')

keymap('n', '<C-j>', '5<C-e>')
keymap('n', '<C-k>', '5<C-y>')

keymap('', 'H', '^')
keymap('', 'L', '$')

keymap('i', '<C-BS>', '<C-w>')

-- Clear search highlighting with <leader> and c
keymap('n', '<leader>c', ':nohl<CR>', { desc = 'Clear search highlighting' })

-- Splits
keymap('n', '<C-a>v', ':vsplit<CR>')
keymap('n', '<C-a>h', ':split<CR>')
keymap('n', '<C-a>x', ':close<CR>')

-- Window navigation
keymap('n', '<A-h>', '<C-w>h')
keymap('n', '<A-j>', '<C-w>j')
keymap('n', '<A-k>', '<C-w>k')
keymap('n', '<A-l>', '<C-w>l')
keymap('n', '<A-w>', '<C-w>w')

-- Resize windows with arrows
keymap('n', '<C-Up>', ':resize -2<CR>')
keymap('n', '<C-Down>', ':resize +2<CR>')
keymap('n', '<C-Left>', ':vertical resize -2<CR>')
keymap('n', '<C-Right>', ':vertical resize +2<CR>')

