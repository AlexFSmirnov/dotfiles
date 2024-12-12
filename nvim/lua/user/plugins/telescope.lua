return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "sharkdp/fd",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local lga_actions = require("telescope-live-grep-args.actions")

      telescope.setup({
        extensions = {
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                -- freeze the current list and start a fuzzy search in the frozen list
                ["<C-space>"] = actions.to_fuzzy_refine,
              },
            },
          },
        },
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
          find_files = {
            hidden = true,
          },
        },
      })

      telescope.load_extension("live_grep_args")
    end,
  },
}
