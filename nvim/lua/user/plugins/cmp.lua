return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "VonHeikement/lsp-zero.nvim",
    "supermaven-inc/supermaven-nvim",
    },
    config = function()
      require("lsp-zero.cmp").extend({})

      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local suggestion = require('supermaven-nvim.completion_preview')
      require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/lua/user/snippets/" } })

      local kind_icons = {
        Text = "",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "",
        Variable = "󰫧",
        Class = "",
        Interface = "",
        Module = "󰆧",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "󰊄",
      }

      local confirmOpts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }

      local cmp_action = require("lsp-zero.cmp").action()
      local cmp_mapping = cmp.mapping

      local jumpOrTab = cmp_mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif cmp.visible() then
          cmp.confirm(confirmOpts)
        else
          fallback()
        end
      end, { "i", "s" })

      local cmpConfirm = cmp_mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm(confirmOpts)
        else
          fallback()
        end
      end, { "i", "s" })

      local suggestionOrConfirm = cmp_mapping(function(fallback)
        if suggestion.has_suggestion() then
          suggestion.on_accept_suggestion()
        elseif cmp.visible() then
          cmp.confirm(confirmOpts)
        else
          fallback()
        end
      end, { "i", "s" })

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp_mapping.complete(),
          ["<A-k>"] = cmp_mapping.select_prev_item(),
          ["<A-j>"] = cmp_mapping.select_next_item(),
          ["<C-d>"] = cmp_mapping.scroll_docs(-4),
          ["<C-f>"] = cmp_mapping.scroll_docs(4),
          ["<CR>"] = cmpConfirm,
          ["<Tab>"] = jumpOrTab,
          ["<A-o>"] = suggestionOrConfirm,
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "tailwindcss" },
          { name = "supermaven "},
        },
      })
    end,
  },
}
