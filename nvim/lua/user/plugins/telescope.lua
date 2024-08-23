return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "sharkdp/fd",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          dynamic_preview_title = true,
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            prompt_position = "top",
            width = 0.9,
            preview_height = 0.5,
          },
          mappings = {
            i = {
              ["<A-Up>"] = actions.cycle_history_prev,
              ["<A-Down>"] = actions.cycle_history_next,

              ["<A-j>"] = actions.move_selection_next,
              ["<A-k>"] = actions.move_selection_previous,

              ["jj"] = actions.close,
              ["<A-q>"] = actions.close,
              ["<Esc>"] = actions.close,

              ["<CR>"] = actions.select_default,
              ["<A-f>"] = actions.select_default,
              ["<A-a>"] = actions.select_default,
              ["<A-o>"] = actions.select_default,

              ["<A-h>"] = actions.select_horizontal,
              ["<A-l>"] = actions.select_vertical,

              ["<A-J>"] = actions.preview_scrolling_down,
              ["<A-K>"] = actions.preview_scrolling_up,

              ["<A-x>"] = actions.delete_buffer,
            },
          },
        },
        pickers = {
          buffers = {
            ignore_current_buffer = true,
            sort_mru = true,
          },
        },
      })
    end,
  },
}
