return {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
        require("onedarkpro").setup({
            styles = {
                comments = "italic",
                keywords = "bold,italic",
                conditionals = "italic",
                parameters = "italic",
                types = "italic",
                methods = "NONE",
                functions = "italic",
                strings = "NONE",
                numbers = "NONE",
                constants = "NONE",
                operators = "NONE",
                variables = "NONE",
                virtual_text = "NONE",
            },
            options = {
                cursorline = true,
                terminal_colors = true,
                highlight_inactive_windows = false,
            },
        })
        vim.cmd("colorscheme onedark_vivid")
    end
}
