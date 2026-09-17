return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            hover = { enabled = true, },
            signature = { enabled = true }
        },
        routes = {
            {
                filter = { event = "msg_show", kind = "", find = "written" },
                opts = { skip = true },
            },
            -- Skip jdtls progress messages
            {
                filter = {
                    event = "lsp",
                    kind = "progress",
                    cond = function(message)
                        local title = vim.tbl_get(message.opts, "progress", "title") or ""
                        local client = vim.tbl_get(message.opts, "progress", "client")
                        return client == "jdtls"
                            and (title:find("Validate documents") or title:find("Publish Diagnostics"))
                    end,
                },
                opts = { skip = true },
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = true,
        },
    },
}
