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

    keys = {
        { "<C-n>",     "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
        { "<leader>e", "<cmd>Neotree focus<CR>",  desc = "Focus Neo-tree" },
    },

    opts = {
        close_if_last_window = true,
        sources = { "filesystem", "buffers", "git_status" },
        use_libuv_file_watcher = true,

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
            hijack_netrw_behavior = "open_default",
            bind_to_cwd = true,
            follow_current_file = {
                enabled = true,
            },
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },

        default_component_configs = {
            name = {
                trailing_slash = false,
                use_git_status_colors = true,
            },
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
