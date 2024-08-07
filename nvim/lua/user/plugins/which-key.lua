return {
  "folke/which-key.nvim",
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    local wk = require("which-key")

    wk.setup({
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
          -- { '<Space>', 'SPC' },
        },
        desc = {
          { "<Plug>%(?(.*)%)?", "%1" },
          { "^%+", "" },
          { "<[cC]md>", "" },
          { "<[cC][rR]>", "" },
          { "<[sS]ilent>", "" },
          { "^lua%s+", "" },
          { "^call%s+", "" },
          { "^:%s*", "" },
        },
      },
    })

    wk.add({
      { "<leader>w", group = "Window" },
      { "<leader>s", group = "Split" },
      { "<leader>t", group = "Tab" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>gs", group = "Git Stash" },
      { "<leader>gf", group = "Git Find" },
      { "<leader>l", group = "LSP" },
      { "<leader>c", group = "CMD Terminal" },
    })
  end,
}
