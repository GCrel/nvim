return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            "MunifTanjim/nui.nvim",
            -- shortcut: nui 3d425a7 (perf(tree)) corrompe el árbol con group_empty_dirs; quitar cuando nui/neo-tree lo arreglen
            commit = "5959922",
        },
        {
            "Crysthamus/nvim-file-operations",
            config = function()
                require("nvim-file-operations").setup()
            end,
        },
    },

    lazy = true,

    cmd = { "Neotree", "Neotree focus", "Neotree reveal_force_cwd" },

    keys = {
        { "<C-n>",     "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
        { "<leader>e", "<cmd>Neotree focus<CR>",  desc = "Focus Neo-tree" },
    },

    opts = {
        close_if_last_window = true,

        source_selector = {
            winbar = true,
        },

        window = {
            position = "right",
            width = 30,
            auto_expand_width = true,
        },

        filesystem = {
            group_empty_dirs = true,
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
