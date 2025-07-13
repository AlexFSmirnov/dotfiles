require("user.keymaps.global")

-- Reload configuration
Map("n", "<leader>r", "<cmd>so %<CR>", { desc = "Reload config" })

-- General mappings
Map("n", "<C-j>", "<C-e>")
Map("n", "<C-k>", "<C-y>")

-- Utils
Map("n", "<leader>kc", "<cmd>nohl<CR>", { desc = "Clear search highlighting" })
Map("n", "<leader>km", "<cmd>%s/\\r//g<CR>", { desc = "Clear Windows line breaks" })
Map("n", "<leader>kw", "<cmd>noautocmd write<CR>", { desc = "Write without formatting" })
Map("n", "<leader>kp", "<cmd>echo expand('%')<CR>", { desc = "Show current file path" })

-- Buffer navigation
Map("n", "<leader><tab>", "<cmd>b#<cr>", { desc = "Switch to last used buffer" })
Map("n", "<A-J>", "<cmd>lua CycleBuffers(1)<CR>")
Map("n", "<A-K>", "<cmd>lua CycleBuffers(-1)<CR>")

-- Splits
Map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Horizontal split" })
Map("n", "<leader>sj", "<cmd>split<cr>", { desc = "Horizontal split" })
Map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
Map("n", "<leader>sl", "<cmd>vsplit<cr>", { desc = "Vertical split" })
Map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close window" })
Map("n", "<leader>sX", "<cmd>bd!<cr>", { desc = "Delete buffer" })

-- Window navigation
Map("n", "<A-h>", "<C-w>h")
Map("n", "<A-j>", "<C-w>j")
Map("n", "<A-k>", "<C-w>k")
Map("n", "<A-l>", "<C-w>l")
Map("t", "<A-h>", "<C-\\><C-n><C-w>h")
Map("t", "<A-j>", "<C-\\><C-n><C-w>j")
Map("t", "<A-k>", "<C-\\><C-n><C-w>k")
Map("t", "<A-l>", "<C-\\><C-n><C-w>l")
Map("n", "<A-w>", "<C-w>w")
Map("n", "<A-q>", "<cmd>close<cr>")
Map("i", "<A-q>", "<cmd>close<cr>")
Map("t", "<A-q>", "<cmd>close<cr>")
Map("n", "<leader>wx", "<cmd>close<cr>", { desc = "Close window" })
Map("n", "<leader>wq", "<cmd>close<cr>", { desc = "Close window" })
Map("n", "<leader>wX", "<cmd>bd!<cr>", { desc = "Delete buffer" })

-- Resize windows with arrows
Map("n", "<C-Up>", "<cmd>resize +2<CR>")
Map("n", "<C-Down>", "<cmd>resize -2<CR>")
Map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
Map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Tab navigation
Map("n", "<A-H>", "gT")
Map("n", "<A-L>", "gt")
Map("t", "<A-H>", "<C-\\><C-n>gT")
Map("t", "<A-L>", "<C-\\><C-n>gt")
Map("n", "<leader>tr", "<cmd>lua SetCurrentTabName(vim.fn.input('Tab name: '))<cr>", { desc = "Rename current tab" })
Map("n", "<leader>tt", "<cmd>tabnew<cr>", { desc = "New tab" })
Map("n", "<leader>tc", "<cmd>tabnew<cr>", { desc = "New tab" })
Map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
Map("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "Close tab" })
Map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close tab" })

-- Folds
Map("n", "zz", "za")
Map("n", "zc", "za")
Map("v", "zc", "zf")

-- Terminal
Map("t", "<Esc>", "<C-\\><C-n>")
Map("t", "jj", "<C-\\><C-n>")
Map("t", "<A-J>", "<C-\\><C-n><cmd>lua CycleTerminals(1)<cr>")
Map("t", "<A-K>", "<C-\\><C-n><cmd>lua CycleTerminals(-1)<cr>")
--    Open terminals
Map("n", "<leader>cc", "<cmd>lua OpenOrCreateTerm()<cr>", { desc = "Open terminal" })
Map("n", "<leader>cn", "<cmd>term<cr>", { desc = "New terminal" })
Map(
  "n",
  "<leader>ch",
  "<cmd>split<cr><cmd>resize 14<cr><cmd>lua OpenOrCreateTerm()<cr>",
  { desc = "Open terminal (H)" }
)
Map(
  "n",
  "<leader>cj",
  "<cmd>split<cr><cmd>resize 14<cr><cmd>lua OpenOrCreateTerm()<cr>",
  { desc = "Open terminal (H)" }
)
Map(
  "n",
  "<leader>cv",
  "<cmd>vsplit<cr><cmd>vertical resize 60<cr><cmd>lua OpenOrCreateTerm()<cr>",
  { desc = "Open terminal (V)" }
)
Map(
  "n",
  "<leader>cl",
  "<cmd>vsplit<cr><cmd>vertical resize 60<cr><cmd>lua OpenOrCreateTerm()<cr>",
  { desc = "Open terminal (V)" }
)

-- nvim-tree
Map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle nvim-tree" })

-- Telescope
local find_terminals = "<cmd>lua require('telescope.builtin').buffers({ default_text = 'term:/' })<cr>"
Map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
Map(
  "n",
  "<leader>fz",
  "<cmd>lua require('telescope.builtin').grep_string({ search = '' })<cr>",
  { desc = "Fuzzy grep" }
)
Map("n", "<leader>fu", "<cmd>Telescope grep_string<cr>", { desc = "Grep under cursor" })
Map(
  "n",
  "<leader>fg",
  "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
  { desc = "Live grep" }
)
Map("n", "<leader>fa", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
Map("n", "<leader>fp", "<cmd>Telescope oldfiles<cr>", { desc = "Find previous files" })
Map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "Find references" })
Map("n", "<leader>fi", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "Find incoming calls" })
Map("n", "<leader>fo", "<cmd>Telescope lsp_outgoing_calls<cr>", { desc = "Find outgoing calls" })
Map("n", "<leader>ft", find_terminals, { desc = "Find terminals" })
Map("n", "<leader>fc", find_terminals, { desc = "Find terminals" })
Map("n", "<leader>fl", "<cmd>Telescope resume<cr>", { desc = "Resume last search" })

-- Git
Map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
Map("n", "<leader>gB", '<cmd>lua require("gitsigns").blame_line{full=true}<cr>', { desc = "Blame line (full)" })
Map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
Map("n", "<leader>gx", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
Map("n", "<leader>gc", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
Map("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
Map("n", "<leader>gss", "<cmd>lua StashStaged()<cr>", { desc = "Stash staged" })
Map("n", "<leader>gfs", "<cmd>Telescope git_stash<cr>", { desc = "Find stashes" })
Map("n", "<leader>gfb", "<cmd>Telescope git_branches<cr>", { desc = "Find branches" })

-- LSP
Map("n", "<leader>lf", "<cmd>Format<cr>", { desc = "ESLint autofix" })
Map("n", "<leader>le", "<cmd>EslintFixAll<cr>", { desc = "ESLint autofix" })
Map("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
Map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover Documentation" })
Map("n", "E", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Open diagnostic" })
Map("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Jump To Definition" })
Map("n", "<leader>jd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Jump To Definition" })
Map("n", "<leader>ji", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Jump To Type Definition" })
Map("n", "<leader>jt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Jump To Type Definition" })
Map("n", "<leader>jD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Jump To Declaration" })
Map("n", "<leader>jr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Jump To References" })
