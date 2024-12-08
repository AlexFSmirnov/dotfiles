return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 35,
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 500,
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NvimTree",
      callback = function()
        vim.opt_local.statuscolumn = ""
      end,
    })
  end,
}
