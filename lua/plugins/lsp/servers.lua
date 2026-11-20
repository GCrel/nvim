return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("mason").setup()

        require("mason-tool-installer").setup({
            ensure_installed = {
                "prettier",
                "java-debug-adapter",
                "java-test",
                "trivy",
            },
            auto_update = false,
            run_on_start = true,
        })


        vim.lsp.config("*", {
            before_init = function(params)
                params.capabilities = vim.tbl_deep_extend("force", params.capabilities,
                    require("util.lsp").capabilities())
            end,
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
        require("config.lsp")
    end,
}
