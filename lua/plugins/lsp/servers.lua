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

        vim.lsp.config("*", {
            capabilities = require("util.lsp").capabilities()

        })

        vim.lsp.config("ltex_plus", {
            filetypes = { "markdown", "text", "gitcommit" },
            settings = {
                ltex = { language = "es-AR" },
            },
        })

        local ng_project_lib = vim.fn.getcwd() .. "/node_modules"
        vim.lsp.config("angularls", {
            cmd = {
                "ngserver", "--stdio",
                "--tsProbeLocations", ng_project_lib,
                "--ngProbeLocations", ng_project_lib,
            },
            root_dir = require("lspconfig.util").root_pattern("angular.json"),
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls", "jdtls", "ltex_plus", "ts_ls", "angularls",
                "html", "cssls", "emmet_ls", "eslint",
            },
            automatic_enable = {
                exclude = { "jdtls" },
            },
        })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, opts)
                vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, opts)
                vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>en", function() vim.diagnostic.jump({ count = 1 }) end, opts)
                vim.keymap.set("n", "<leader>ep", function() vim.diagnostic.jump({ count = -1 }) end, opts)
                vim.keymap.set("n", "<leader>eq", vim.diagnostic.setloclist, opts)
                vim.keymap.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, opts)
            end,
        })

        vim.diagnostic.config({
            update_in_insert = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN]  = " ",
                    [vim.diagnostic.severity.HINT]  = " ",
                    [vim.diagnostic.severity.INFO]  = " ",
                },
            },
        })

        vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = false, underline = true, sp = "#ff5555" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = false, underdotted = true, sp = "#ffb86c" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = false, underdashed = true, sp = "#8be9fd" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = false, underline = true, sp = "#50fa7b" })

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
