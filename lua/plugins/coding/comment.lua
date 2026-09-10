return {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local api = require("Comment.api")

        vim.keymap.set(
            "n",
            "<C-_>",
            api.toggle.linewise.current,
            { noremap = true, silent = true, desc = "Toggle comment line" }
        )

        vim.keymap.set(
            "v",
            "<C-_>",
            function()
                api.toggle.linewise(vim.fn.visualmode())
            end,
            { noremap = true, silent = true, desc = "Toggle comment selection" }
        )

        require("Comment").setup()
    end,
}
