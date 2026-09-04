return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    keys = {
        { "<F5>", "<cmd>lua require'dap'.continue()<CR>", desc = "Iniciar/Continuar Debug" },
        { "<F10>", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step Over" },
        { "<F11>", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step Into" },
        { "<F12>", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step Out" },
        { "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- Inicializar la interfaz gráfica
        dapui.setup()

        -- Automatización: Abrir paneles al iniciar, cerrar al terminar
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
