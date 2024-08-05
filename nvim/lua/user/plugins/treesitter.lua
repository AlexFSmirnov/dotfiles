return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = function()
			pcall(require('nvim-treesitter.install').update({ with_sync = true }))
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = {
          'c',
          'cpp',
          'go',
          'lua',
          'python',
          'rust',
          'vimdoc',
          'vim',
          'markdown',
          'markdown_inline',
          'bash',
          'typescript',
          'javascript',
          'tsx',
        },

				highlight = { enable = true },
        autopairs = { enable = true },
				indent = { enable = true, disable = { 'python', 'css' } },
			})
		end,
	},
}
