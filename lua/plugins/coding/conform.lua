return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    dependencies = {
        "zapling/mason-conform.nvim",
    },
    keys = {
        {
            "<leader>fm",
            function()
                require("conform").format({ lsp_fallback = true })
            end,
            mode = "n",
            desc = "Formatear documento",
        },
    },
    opts = {
        formatters_by_ft = {
            java = { "google-java-format" },
        },
        formatters = {
            ["google-java-format"] = {
                prepend_args = { "--aosp" },
            },
        },
        format_on_save = {
            timeout_ms = 1000,
            lsp_format = "fallback",
        },
    },
    config = function(_, opts)
        require("conform").setup(opts)
        
        require("mason-conform").setup({
            ensure_installed = { "google-java-format" },
        })
    end,
}
