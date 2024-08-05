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
keymap('n', '<leader>r', ':so %<CR>')

-- General mappings
keymap('n', ';', ':', { silent = false })
keymap('i', 'jj', '<Esc>')
keymap('c', 'jj', '<C-c>')

keymap('n', '<C-j>', '5<C-e>')
keymap('n', '<C-k>', '5<C-y>')

keymap('', 'H', '^')
keymap('', 'L', '$')

-- Clear search highlighting with <leader> and c
keymap('n', '<leader>c', ':nohl<CR>')

-- Splits
keymap('n', '<C-a>v', ':vsplit<CR>')
keymap('n', '<C-a>h', ':split<CR>')

-- Window navigation
keymap('n', '<A-h>', '<C-w>h')
keymap('n', '<A-j>', '<C-w>j')
keymap('n', '<A-k>', '<C-w>k')
keymap('n', '<A-l>', '<C-w>l')

-- Resize windows with arrows
keymap('n', '<C-Up>', ':resize -2<CR>')
keymap('n', '<C-Down>', ':resize +2<CR>')
keymap('n', '<C-Left>', ':vertical resize -2<CR>')
keymap('n', '<C-Right>', ':vertical resize +2<CR>')

-- LSP keymaps setup function
local function lsp_keymaps(bufnr)
    local buf_map = function(mode, lhs, rhs, desc)
        local opts = { noremap = true, silent = true, desc = desc }
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    buf_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Documentation")
    buf_map("n", "E", "<cmd>lua vim.diagnostic.open_float()<CR>", "Open diagnostic")

    buf_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition")
    buf_map("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition")
    buf_map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition")
    buf_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration")
    buf_map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Goto References")

    buf_map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol")
    buf_map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action")
    buf_map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition")
    buf_map("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation")


    -- Create a command :Format local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format({ async = true })
    end, { desc = "Format current buffer with LSP" })

    buf_map("n", "<leader>ff", "<cmd>Format<CR>", "Format")
end

return {
    lsp_keymaps = lsp_keymaps,
}
