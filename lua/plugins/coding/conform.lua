return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    dependencies = {
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            dependencies = { "williamboman/mason.nvim" },
            opts = {
                ensure_installed = { "prettier" },
            },
        },
    },
    keys = {
        {
            "<leader>fm",
            function()
                require("conform").format({ lsp_format = "fallback" })
            end,
            mode = "n",
            desc = "Formatear documento",
        },
    },
    opts = {
        formatters_by_ft = {
            typescript = { "prettier" },
            html = { "prettier" },
            scss = { "prettier" },
            css = { "prettier" },
        },
        format_on_save = {
            timeout_ms = 1000,
            lsp_format = "fallback",
        },
    },
}
