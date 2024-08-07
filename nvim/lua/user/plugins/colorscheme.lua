return {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 100,
  config = function()
    require("vscode").setup({})

    vim.cmd.colorscheme("vscode")
  end,
}
