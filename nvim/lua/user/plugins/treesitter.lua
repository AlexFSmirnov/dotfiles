return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "yioneko/nvim-yati",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "cpp",
          "go",
          "lua",
          "python",
          "rust",
          "vimdoc",
          "vim",
          "markdown",
          "markdown_inline",
          "bash",
          "typescript",
          "javascript",
          "tsx",
        },

        yati = {
          enable = true,
          default_fallback = "auto",
        },

        highlight = { enable = true },
        autopairs = { enable = true },
        indent = { enable = false },
      })
    end,
  },
}
