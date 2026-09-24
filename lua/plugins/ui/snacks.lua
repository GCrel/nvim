return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        -- Search and pickers
        picker = {
            enabled = true,
            ui_select = true,
            layout = { preset = "telescope" },
            matcher = {
                frecency = true,
            },
        },

        -- Git
        lazygit = { enabled = true },
        gitbrowse = { enabled = true },

        -- Initial UI
        dashboard = {
            enabled = true,
            preset = {
                header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝    ╚═╝
                ]],
                keys = {
                    { icon = " ", key = "e", desc = "New file", action = ":ene | startinsert" },
                    { icon = " ", key = "f", desc = "Find file", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "r", desc = "Recent", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "s", desc = "Settings", action = ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd" },
                    { icon = "󰩈 ", key = "q", desc = "Quit NVIM", action = ":qa" },
                },
            },
            sections = {
                { section = "header" },
                { section = "keys",  gap = 1, padding = 1 },
                function()
                    local date = " " .. os.date("%d:%m:%Y")
                    local time = " " .. os.date("%H:%M:%S")
                    local v = vim.version()
                    local version = " v" .. v.major .. "." .. v.minor .. "." .. v.patch
                    local plugins = " " .. (require("lazy").stats().count or 0)

                    return {
                        { align = "center", text = { { time .. "   " .. date, hl = "NonText" } },      padding = 1 },
                        { align = "center", text = { { version .. "   " .. plugins, hl = "NonText" } } },
                    }
                end,
                { section = "startup", padding = 1 },
            },
        },

        -- Other features
        image = {
            enabled = true,
            formats = {
                "png", "jpg", "jpeg", "gif", "webp", "avif"
            },
            max_width = nil,
            max_height = nil,
        },

        notifier = {
            enabled = true,
            timeout = 3000,
        },

        terminal = { enabled = true },
        indent = { enabled = true },
        words = { enabled = true },
        scratch = { enabled = true },
        statuscolumn = { enabled = true },
    },

    keys = {
        -- Picker
        { "<leader>p",  function() Snacks.picker.files({ exclude = { "node_modules" } }) end, desc = "Find files" },
        { "<leader>f",  function() Snacks.picker.grep() end,                                  desc = "Grep" },
        { "<leader>o",  function() Snacks.picker.recent() end,                                desc = "Old files" },
        { "<leader>b",  function() Snacks.picker.buffers() end,                               desc = "Buffers" },

        -- Git
        { "<leader>gd", function() Snacks.picker.git_diff() end,                              desc = "Git Diffs" },
        { "<leader>gg", function() Snacks.lazygit() end,                                      desc = "Lazygit" },
        { "<leader>gb", function() Snacks.gitbrowse() end,                                    desc = "Git Browse" },

        -- Terminal
        {
            "<leader>th",
            function()
                Snacks.terminal.toggle(nil, {
                    win = { position = "bottom", height = 12 }
                })
            end,
            desc = "Terminal Horizontal"
        },
        {
            "<leader>tf",
            function()
                Snacks.terminal.toggle(nil, {
                    win = {
                        position = "float",
                        border = "shadow",
                        width = 0.5,
                        height = 0.5
                    }
                })
            end,
            desc = "Terminal Flotante"
        },

        -- Scratch
        { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" }
    }
}
