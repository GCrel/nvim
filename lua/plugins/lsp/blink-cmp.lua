return {
    "saghen/blink.cmp",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
    },
    opts = {
        -- 'super-tab' viene integrado y reemplaza toda tu lógica de <Tab> y <S-Tab>
        keymap = {
            preset = "super-tab",
            ["<C-k>"] = { "scroll_documentation_up", "fallback" },
            ["<C-l>"] = { "scroll_documentation_down", "fallback" },
            ["<C-Space>"] = { "show", "fallback" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
        },

        snippets = { preset = "luasnip" },

        -- Fuentes incluidas por defecto (ya no necesitas instalar cmp-buffer, cmp-path, etc.)
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
        },

        completion = {
            menu = { border = "single" },
            documentation = { auto_show = true, window = { border = "single" } },
        },

        appearance = {
            -- Blink maneja los iconos nativamente sin necesidad de lspkind
            kind_icons = {
                Text = "",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰇽",
                Variable = "󰂡",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
            },
        },
    },
}
