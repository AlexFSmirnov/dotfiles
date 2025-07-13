require("user.keymaps.global")

-- Remap navigation to move over folds
Map("n", "j", "<cmd>lua require('vscode').action('cursorDown')<CR>")
Map("n", "k", "<cmd>lua require('vscode').action('cursorUp')<CR>")

-- Use vscode's undo and redo
Map("n", "u", "<cmd>lua require('vscode').action('undo')<CR>")
Map("n", "<C-r>", "<cmd>lua require('vscode').action('redo')<CR>")

-- Primary sidebar
Map("n", "<leader>s", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>", { desc = "Show/Hide sidebar" })
Map("n", "<leader>e", "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>", { desc = "Open explorer" })
Map("n", "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>", { desc = "Find file" })
Map("n", "<leader>fp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>", { desc = "Show command pallette" })
Map("n", "<leader>fg", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>", { desc = "File search" })
Map("n", "<leader>gd", "<cmd>lua require('vscode').action('workbench.scm.focus')<CR>", { desc = "Focus source control" })

-- Bottom panel
Map("n", "<leader>cj", "<cmd>lua require('vscode').action('workbench.action.togglePanel')<CR>", { desc = "Focus panel" })

-- Folding
Map("v", "zc", function()
  require("vscode").action("editor.createFoldingRangeFromSelection")
  vim.defer_fn(function()

    -- Wait for the folding to be applied
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  end, 100)
end, { desc = "Fold selection" })
Map("n", "zc", "<cmd>lua require('vscode').action('editor.toggleFold')<CR>", { desc = "Fold" })
Map("n", "zx", "<cmd>lua require('vscode').action('editor.removeManualFoldingRanges')<CR>", { desc = "Remove fold range" })

-- LSP
Map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover Documentation" })
Map("n", "<leader>jd", "<cmd>lua require('vscode').action('editor.action.revealDefinition')<CR>", { desc = "Goto definition" })
Map("n", { "<leader>ji", "<leader>jt" }, "<cmd>lua require('vscode').action('editor.action.goToTypeDefinition')<CR>", { desc = "Jump To Type Definition" })
Map("n", "<leader>jr", "<cmd>lua require('vscode').action('editor.action.goToReferences')<CR>", { desc = "Jump To References" })

-- Cursor
Map({ "n", "v" }, "<leader>cc", "<cmd>lua require('vscode').action('aichat.newchataction')<CR>", { desc = "Open cursor chat" })
Map("n", { "<leader>cq", "<leader>cx" }, "<cmd>lua require('vscode').action('aichat.close-sidebar')<CR>", { desc = "Close cursor chat" })
Map({ "n", "v" }, "<leader>cn", "<cmd>lua require('vscode').action('composer.createNewWithPrevContext')<CR>", { desc = "Open new cursor chat" })
Map({ "n", "v" }, "<leader>cq", "<cmd>lua require('vscode').action('aipopup.action.modal.generate')<CR>", { desc = "Quick edit" })

-- Edits
Map("n", { "<leader>dh", "<leader>dn" }, "<cmd>lua require('vscode').action('editor.action.inlineDiffs.rejectPartialEdit')<CR>", { desc = "Reject edit" })
Map("n", { "<leader>dl", "<leader>dy" }, "<cmd>lua require('vscode').action('editor.action.inlineDiffs.acceptPartialEdit')<CR>", { desc = "Accept edit" })
Map("n", "<leader>dj", "<cmd>lua require('vscode').action('editor.action.inlineDiffs.nextChange')<CR>", { desc = "Next edit" })
Map("n", "<leader>dk", "<cmd>lua require('vscode').action('editor.action.inlineDiffs.previousChange')<CR>", { desc = "Previous edit" })
