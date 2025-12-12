return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
        { "nvim-telescope/telescope-fzy-native.nvim", lazy = true },
    },

    -- 💡 Lazy-load cuando se usan los atajos
    keys = {
        { "<C-F>", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
        { "<C-P>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<C-o>", "<cmd>Telescope oldfiles<cr>", desc = "Old files" },
    },

    cmd = "Telescope", -- también carga cuando ejecutas :Telescope

    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "-L",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = { preview_cutoff = 0 },
                    vertical = { width = 0.95, anchor = 2 },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = { "node_modules" },
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                path_display = { "truncate" },
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                color_devicons = true,
                set_env = { ["COLORTERM"] = "truecolor" },
                mappings = {
                    n = {
                        ["q"] = require("telescope.actions").close,
                    },
                },
            },
            extensions = {
                fzy_native = {
                    override_generic_sorter = false,
                    override_file_sorter = true,
                },
            },
        })

        telescope.load_extension("fzy_native")
        telescope.load_extension("file_browser")
    end,
}

