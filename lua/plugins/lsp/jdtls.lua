return {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function()
        local jdtls = require('jdtls')
        local mason_data = vim.fn.stdpath("data") .. "/mason"

        local capabilities = require("util.lsp").capabilities()

        local bundles = {}
        local java_debug_path = vim.fn.glob(
            mason_data .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
        if java_debug_path ~= "" then
            vim.list_extend(bundles, vim.split(java_debug_path, "\n"))
        end

        local java_test_path = vim.fn.glob(mason_data .. "/packages/java-test/extension/server/*.jar", true)
        if java_test_path ~= "" then
            vim.list_extend(bundles, vim.split(java_test_path, "\n"))
        end

        local lombok_path = mason_data .. "/packages/jdtls/lombok.jar"

        local extendedClientCapabilities = jdtls.extendedClientCapabilities
        extendedClientCapabilities.resolveAdditionalTextEditsOnCompletionAcceptance = true

        local dap_ready = false

        vim.api.nvim_create_user_command("FormatProject", function()
            local files = vim.fn.systemlist("find src -name '*.java'")
            for i, file in ipairs(files) do
                vim.cmd("edit " .. vim.fn.fnameescape(file))
                local bufnr = vim.api.nvim_get_current_buf()
                vim.wait(20000, function()
                    return #vim.lsp.get_clients({ bufnr = bufnr, name = "jdtls" }) > 0
                end, 100)
                require("conform").format({ bufnr = bufnr, lsp_format = "fallback", timeout_ms = 5000 })
                vim.cmd("write")
                print(string.format("(%d/%d) %s", i, #files, file))
            end
            print("Listo: " .. #files .. " archivos formateados.")
        end, {})

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                local root_dir = vim.fs.root(0, {
                    'pom.xml', 'mvnw', 'build.gradle', 'build.gradle.kts', 'gradlew', '.git',
                })
                if not root_dir then
                    return
                end

                local project_name = vim.fn.fnamemodify(root_dir, ':t')
                local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. project_name

                local config = {
                    capabilities = capabilities,
                    init_options = {
                        bundles = bundles,
                        extendedClientCapabilities = extendedClientCapabilities,
                    },
                    cmd = {
                        mason_data .. "/bin/jdtls",
                        '--jvm-arg=-javaagent:' .. lombok_path,
                        '-data', workspace_dir,
                    },
                    root_dir = root_dir,
                    settings = {
                        java = {
                            signatureHelp = { enabled = true },
                            completion = {
                                favoriteStaticMembers = {
                                    "org.junit.jupiter.api.Assertions.*",
                                    "org.mockito.Mockito.*",
                                },
                            },
                        },
                    },
                    on_attach = function(_, bufnr)
                        vim.keymap.set('n', '<leader>jo', jdtls.organize_imports,
                            { desc = "Organizar Imports", buffer = bufnr })
                        vim.keymap.set('n', '<leader>jv', jdtls.extract_variable,
                            { desc = "Extraer Variable", buffer = bufnr })
                        vim.keymap.set('n', '<leader>jc', jdtls.extract_constant,
                            { desc = "Extraer Constante", buffer = bufnr })
                        vim.keymap.set('n', '<leader>tc', jdtls.test_class,
                            { desc = "Ejecutar Test de Clase", buffer = bufnr })
                        vim.keymap.set('n', '<leader>tm', jdtls.test_nearest_method,
                            { desc = "Ejecutar Test Cercano", buffer = bufnr })

                        if not dap_ready then
                            jdtls.setup_dap({
                                hotcodereplace = 'auto',
                                config_overrides = {}
                            })
                            require('jdtls.dap').setup_dap_main_class_configs()
                            dap_ready = true
                        end
                    end,
                }

                jdtls.start_or_attach(config)
            end,
        })
    end,
}
