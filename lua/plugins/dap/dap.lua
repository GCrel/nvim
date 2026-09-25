return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = { "williamboman/mason.nvim" },
            opts = {
                ensure_installed = { "java-debug-adapter", "java-test" },
                automatic_installation = true,
                handlers = {},
            },
        },
    },
    keys = {
        { "<F5>",       function() require("dap").continue() end,          desc = "Iniciar/Continuar Debug" },
        { "<F10>",      function() require("dap").step_over() end,         desc = "Step Over" },
        { "<F11>",      function() require("dap").step_into() end,         desc = "Step Into" },
        { "<F12>",      function() require("dap").step_out() end,          desc = "Step Out" },
        { "<leader>tb", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end
}
