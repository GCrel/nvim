return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        {
            "antosha417/nvim-lsp-file-operations",
            config = true,
        },
    },

    lazy = false,

    keys = {
        { "<C-n>",     "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
        { "<leader>e", "<cmd>Neotree focus<CR>",  desc = "Focus Neo-tree" },
    },

    opts = {
        close_if_last_window = true,
        sources = { "filesystem" },

        source_selector = {
            winbar = true,
        },

        window = {
            position = "right",
            width = 30,
            auto_expand_width = true,
        },

        filesystem = {
            group_empty_dirs = false,
            follow_current_file = {
                enabled = true,
            },
            use_libuv_file_watcher = true,
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },

        default_component_configs = {
            git_status = {
                symbols = {
                    unstaged = "✗",
                    staged = "✓",
                    modified = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
            },
            icon = {
                folder_closed = "󰉋",
                folder_open = "",
                folder_empty = "",
                default = "󰈚",
            },
        },
    },
}
