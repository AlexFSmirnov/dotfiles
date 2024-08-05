return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'folke/which-key.nvim',
      'BurntSushi/ripgrep',
      'sharkdp/fd',
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local wk = require('which-key')

      telescope.setup({
        defaults = {
          path_display = { "smart" },
          dynamic_preview_title = true,
          sorting_strategy = 'ascending',
          layout_strategy = "vertical",
          layout_config = {
            prompt_position = 'top',
            width = 0.9,
            preview_height = 0.5,
          },
          mappings = {
            i = {
              ['<A-Up>'] = actions.cycle_history_prev,
              ['<A-Down>'] = actions.cycle_history_next,

              ['<A-j>'] = actions.move_selection_next,
              ['<A-k>'] = actions.move_selection_previous,

              ['jj'] = actions.close,
              ['<A-q>'] = actions.close,
              ['<Esc>'] = actions.close,

              ['<CR>'] = actions.select_default,
              ['<A-h>'] = actions.select_horizontal,
              ['<A-l>'] = actions.select_vertical,

              ['<A-J>'] = actions.preview_scrolling_down,
              ['<A-K>'] = actions.preview_scrolling_up,
            },
          },
        },
      })

      wk.add({
        { '<leader>f',  group = 'Find' },
        { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
        { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
        { '<leader>fa', '<cmd>Telescope buffers<cr>', desc = 'Find buffers' },
        { '<leader>fp', '<cmd>Telescope oldfiles<cr>', desc = 'Find previous files' },
        { '<leader>fr', '<cmd>Telescope lsp_references<cr>', desc = 'Find references' },
        { '<leader>fi', '<cmd>Telescope lsp_incoming_calls<cr>', desc = 'Find incoming calls' },
        { '<leader>fo', '<cmd>Telescope lsp_outgoing_calls<cr>', desc = 'Find outgoing calls' },
      })
    end
  }
}
