return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-0>",
        },
        color = {
          suggestion_color = "#888888",
          cterm = 244,
        },
        log_level = "off",
      })
    end,
  },
}
