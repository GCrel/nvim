return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<C-y>",
                    next = "<A-]>",
                    prev = "<A-[>",
                    dismiss = "<C-\\>",
                },
            },
            panel = { enabled = false },
        })
    end,
}
