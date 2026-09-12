return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("mason").setup()

        local capabilities = require('blink.cmp').get_lsp_capabilities()

        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "jdtls", "ltex_plus", "ts_ls", "angularls", "html", "cssls", "emmet_ls",
                "eslint",
            },

            automatic_enable = {
                exclude = { "jdtls", "ltex_plus", "angularls" },
            },

            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true),
                                    checkThirdParty = false,
                                },
                                telemetry = { enable = false },
                            },
                        },
                    })
                end,

                ["ltex_plus"] = function()
                    require("lspconfig").ltex.setup({
                        capabilities = capabilities,
                        filetypes = { "markdown", "text", "gitcommit" },
                        settings = {
                            ltex = {
                                language = "es-AR",
                            },
                        },
                    })
                end,

                ["angularls"] = function()
                    local project_library_path = vim.fn.getcwd() .. "/node_modules"
                    local cmd = {
                        "ngserver", "--stdio",
                        "--tsProbeLocations", project_library_path,
                        "--ngProbeLocations", project_library_path,
                    }
                    require("lspconfig").angularls.setup({
                        capabilities = capabilities,
                        cmd = cmd,
                        on_new_config = function(new_config, _)
                            new_config.cmd = cmd
                        end,
                        root_dir = require("lspconfig.util").root_pattern("angular.json"),
                    })
                end,
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>eq", vim.diagnostic.setloclist, opts)
            end,
        })

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN]  = " ",
                    [vim.diagnostic.severity.HINT]  = " ",
                    [vim.diagnostic.severity.INFO]  = " ",
                },
            },
        })

        vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
                vim.diagnostic.open_float(nil, {
                    focus = false,
                    border = "rounded",
                    source = "always",
                })
            end,
        })
    end,
}
