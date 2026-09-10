return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        options = {
            mode = "buffers",
            numbers = "none",
            diagnostics = "nvim_lsp",

            separator_style = "slope",

            show_buffer_close_icons = true,
            show_close_icon = true,
            color_icons = true,
            enforce_regular_tabs = false,
            always_show_bufferline = false,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    highlight = "Directory",
                    separator = true,
                },
            },
        },
    },
}
