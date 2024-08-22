local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }

  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Reload configuration
map("n", "<leader>r", "<cmd>so %<CR>", { desc = "Reload config" })

-- General mappings
map("n", ";", ":", { silent = false })
map("i", "jj", "<Esc>")
map("c", "jj", "<C-c>")

map("n", "<C-j>", "5<C-e>")
map("n", "<C-k>", "5<C-y>")
map("n", "<C-h>", "5zh")
map("n", "<C-l>", "5zl")

map("", "H", "^")
map("", "L", "$")

map("i", "<C-BS>", "<C-w>")
map("c", "<C-BS>", "<C-w>", { silent = false })

-- Clear search highlighting with <leader> and c
map("n", "<leader>lc", "<cmd>nohl<CR>", { desc = "Clear search highlighting" })

-- Clear Windows line breaks with <leader> and m
map("n", "<leader>m", "<cmd>%s/\\r//g<CR>", { desc = "Clear Windows line breaks" })

-- Buffer navigation
map("n", "<leader><tab>", "<cmd>b#<cr>", { desc = "Switch to last used buffer" })

-- Splits
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>sj", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>sl", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close window" })
map("n", "<leader>sX", "<cmd>bd!<cr>", { desc = "Delete buffer" })

-- Window navigation
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")
map("t", "<A-h>", "<C-\\><C-n><C-w>h")
map("t", "<A-j>", "<C-\\><C-n><C-w>j")
map("t", "<A-k>", "<C-\\><C-n><C-w>k")
map("t", "<A-l>", "<C-\\><C-n><C-w>l")
map("n", "<A-w>", "<C-w>w")
map("n", "<A-q>", "<cmd>close<cr>")
map("i", "<A-q>", "<cmd>close<cr>")
map("t", "<A-q>", "<cmd>close<cr>")
map("n", "<leader>wx", "<cmd>close<cr>", { desc = "Close window" })
map("n", "<leader>wq", "<cmd>close<cr>", { desc = "Close window" })
map("n", "<leader>wX", "<cmd>bd!<cr>", { desc = "Delete buffer" })

-- Resize windows with arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Tab navigation
map("n", "<A-H>", "gT")
map("n", "<A-L>", "gt")
map("t", "<A-H>", "<C-\\><C-n>gT")
map("t", "<A-L>", "<C-\\><C-n>gt")
map("n", "<leader>tr", "<cmd>lua SetCurrentTabName(vim.fn.input('Tab name: '))<cr>", { desc = "Rename current tab" })
map("n", "<leader>tt", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close tab" })

-- Folds
map("n", "zz", "za")
map("n", "zc", "za")
map("v", "zc", "zf")

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>")
map("t", "jj", "<C-\\><C-n>")
map("t", "<A-J>", "<C-\\><C-n><cmd>lua CycleTerminals(1)<cr>")
map("t", "<A-K>", "<C-\\><C-n><cmd>lua CycleTerminals(-1)<cr>")
map("n", "<A-J>", "<cmd>lua CycleTerminals(1)<cr>")
map("n", "<A-K>", "<cmd>lua CycleTerminals(-1)<cr>")
--    Open terminals
map("n", "<leader>cc", "<cmd>lua OpenOrCreateTerm()<cr>", { desc = "Open terminal" })
map("n", "<leader>cn", "<cmd>term<cr>", { desc = "New terminal" })
map(
  "n",
  "<leader>ch",
  "<cmd>split<cr><cmd>resize 14<cr><cmd>lua OpenOrCreateTerm()<cr>",
  { desc = "Open terminal (H)" }
)
map(
  "n",
  "<leader>cj",
  "<cmd>split<cr><cmd>resize 14<cr><cmd>lua OpenOrCreateTerm()<cr>",
  { desc = "Open terminal (H)" }
)
map(
  "n",
  "<leader>cv",
  "<cmd>vsplit<cr><cmd>vertical resize 60<cr><cmd>lua OpenOrCreateTerm()<cr>",
  { desc = "Open terminal (V)" }
)
map(
  "n",
  "<leader>cl",
  "<cmd>vsplit<cr><cmd>vertical resize 60<cr><cmd>lua OpenOrCreateTerm()<cr>",
  { desc = "Open terminal (V)" }
)

-- nvim-tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle nvim-tree" })

-- Telescope
local find_terminals = "<cmd>lua require('telescope.builtin').buffers({ default_text = 'term:/' })<cr>"
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').grep_string({ search = '' })<cr>", { desc = "Live grep" })
map("n", "<leader>fu", "<cmd>Telescope grep_string<cr>", { desc = "Grep under cursor" })
map("n", "<leader>fa", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fp", "<cmd>Telescope oldfiles<cr>", { desc = "Find previous files" })
map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "Find references" })
map("n", "<leader>fi", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "Find incoming calls" })
map("n", "<leader>fo", "<cmd>Telescope lsp_outgoing_calls<cr>", { desc = "Find outgoing calls" })
map("n", "<leader>ft", find_terminals, { desc = "Find terminals" })
map("n", "<leader>fc", find_terminals, { desc = "Find terminals" })

-- Git
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
map("n", "<leader>gB", '<cmd>lua require("gitsigns").blame_line{full=true}<cr>', { desc = "Blame line (full)" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
map("n", "<leader>gx", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
map("n", "<leader>gc", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
map("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
map("n", "<leader>gss", "<cmd>lua StashStaged()<cr>", { desc = "Stash staged" })
map("n", "<leader>gfs", "<cmd>Telescope git_stash<cr>", { desc = "Find stashes" })
map("n", "<leader>gfb", "<cmd>Telescope git_branches<cr>", { desc = "Find branches" })

-- LSP
map("n", "<leader>lf", "<cmd>Format<cr>", { desc = "ESLint autofix" })
map("n", "<leader>le", "<cmd>EslintFixAll<cr>", { desc = "ESLint autofix" })
map("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover Documentation" })
map("n", "E", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Open diagnostic" })
map("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Jump To Definition" })
map("n", "<leader>jd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Jump To Definition" })
map("n", "<leader>ji", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Jump To Type Definition" })
map("n", "<leader>jt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Jump To Type Definition" })
map("n", "<leader>jD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Jump To Declaration" })
map("n", "<leader>jr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Jump To References" })
