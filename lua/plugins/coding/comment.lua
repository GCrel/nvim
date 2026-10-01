return {
    "numToStr/Comment.nvim",
    cmd = "Comment",
    keys = {
        {
            "<C-/>",
            function() require("Comment.api").toggle.linewise.current() end,
            mode = "n",
            desc = "Toggle comment line",
        },
        {
            "<C-/>",
            function() require("Comment.api").toggle.linewise(vim.fn.visualmode()) end,
            mode = "v",
            desc = "Toggle comment selection",
        },
    },
    opts = {},
}
