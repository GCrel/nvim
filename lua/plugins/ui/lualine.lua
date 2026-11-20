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
                disabled_filetypes = { 'snacks_dashboard', 'lazy', 'TelescopePrompt' },
                globalstatus = true,
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
        })

        -- Con globalstatus, disabled_filetypes no oculta la barra; se pausa lualine mientras el dashboard está abierto
        -- (lualine reimpone laststatus en cada refresco, por eso hide() va antes de laststatus = 0)
        local function set_dashboard(open)
            require("lualine").hide({ place = { "statusline" }, unhide = not open })
            if open then vim.o.laststatus = 0 end
        end
        local group = vim.api.nvim_create_augroup("LualineDashboard", {})
        vim.api.nvim_create_autocmd("User", {
            group = group,
            pattern = "SnacksDashboardOpened",
            callback = function() set_dashboard(true) end,
        })
        vim.api.nvim_create_autocmd("User", {
            group = group,
            pattern = "SnacksDashboardClosed",
            callback = function() set_dashboard(false) end,
        })
        -- el dashboard puede abrirse antes de que cargue lualine
        if vim.bo.filetype == "snacks_dashboard" then set_dashboard(true) end
    end,
}
