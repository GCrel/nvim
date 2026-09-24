return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
        require('lualine').setup({
            options = {
                theme = 'onedark',
                component_separators = { left = '╱', right = '╱' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = { 'alpha', 'lazy', 'TelescopePrompt' },
                global_status = true,
            },
            sections = {
                -- Left
                lualine_a = {
                    { 'mode', separator = { left = '', right = '' } }
                },
                lualine_b = {
                    { 'branch', icon = '' }
                },
                lualine_c = {},

                -- Right
                lualine_x = {
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic' },
                        sections = { 'error', 'warn', 'info' },
                        symbols = { error = " ", warn = " ", info = " " },
                    }
                },
                lualine_y = {},
                lualine_z = {
                    {
                        'filename',
                        file_status = true,
                        path = 0,
                        icon_only = false,
                        separator = { left = '', right = '' }
                    }
                }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            extensions = { 'neo-tree', 'lazy' }
        })
    end,
}
