return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/which-key.nvim',
  },
  config = function()
    require('nvim-tree').setup({
      view = {
        width = 35,
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
    })

    require('which-key').add({
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle nvim-tree' },
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'NvimTree',
      callback = function()
        vim.opt_local.statuscolumn = ''
      end
    })
  end,
}
