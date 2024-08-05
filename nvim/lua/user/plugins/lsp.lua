return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- Set up Mason before anything else
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "tsserver",
                    "basedpyright",
                },
                automatic_installation = true,
            })

            local lsp_keymaps = require('user.keymaps').lsp_keymaps

            -- This function gets run when an LSP connects to a particular buffer.
            local on_attach = function(_client, bufnr)
                lsp_keymaps(bufnr)
            end

            -- Set up sign icons for diagnostics
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end


            -- Diagnostic config
            local config = {
                virtual_text = true,
                signs = true,
                update_in_insert = true,
                underline = false,

                severity_sort = true,
                float = {
                    focusable = true,
                    -- style = "minimal",
                    border = "rounded",
                    source = "always",

                    header = "",
                    prefix = "",
                },

            }
            vim.diagnostic.config(config)

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            -- Lua
            require("lspconfig")["lua_ls"].setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",

                        },
                        diagnostics = {
                            globals = { "vim" },

                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            })

            -- TypeScript
            require("lspconfig")["tsserver"].setup({
                on_attach = on_attach,
                capabilities = capabilities,

            })

            -- Python
            require("lspconfig")["basedpyright"].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,
    },
}
