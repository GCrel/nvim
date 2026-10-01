return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
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
            lsp_format = "never",
            timeout_ms = 1000,
        },
    },
}
