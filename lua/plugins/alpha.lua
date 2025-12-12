return{
  'goolord/alpha-nvim',
  requires = { 'nvim-tree/nvim-web-devicons' },
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    local date = " " .. os.date("%d:%m:%Y")
    local time = " " .. os.date("%H:%M:%S")
    local v = vim.version()
    local version = " v" .. v.major .. "." .. v.minor .. "." .. v.patch
    local plugins = "   " .. #vim.tbl_keys(require("lazy").plugins())

    -- Set header
    dashboard.section.header.val = {
        '',
        '                                                     ',
        '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
        '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
        '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
        '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
        '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
        '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
        '                                                     ',
        '',
    }

    -- Set menu
    dashboard.section.buttons.val = {
        dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
        dashboard.button( "f", "  > Find file", ":Telescope find_files<CR>"),
        dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
        dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
        dashboard.button( "q", "󰩈  > Quit NVIM", ":qa<CR>"),
    }

    dashboard.section.footer.val = {
        " ",
        " " .. time .. " " .. " " .. date .. " ",
        " " .. version.. " " .. " " .. plugins .. " ",
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)
    -- Disable folding on alpha buffer
    vim.cmd([[
        autocmd FileType alpha setlocal nofoldenable
    ]])
  end
}
