return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = ":TSUpdate",

    -- Avoid error in windows
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    dependencies = {
        {
            "nvim-treesitter/playground",
            cmd = "TSPlaygroundToggle",
        },
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },

    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "lua" },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
