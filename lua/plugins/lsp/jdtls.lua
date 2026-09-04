return {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                local jdtls = require('jdtls')
                local capabilities = require('cmp_nvim_lsp').default_capabilities()

                local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
                local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. project_name

                local bundles = {}

                local java_debug_path = vim.fn.glob(
                    vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
                    true
                )
                if java_debug_path ~= "" then
                    vim.list_extend(bundles, vim.split(java_debug_path, "\n"))
                end

                local java_test_path = vim.fn.glob(
                    vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar",
                    true
                )
                if java_test_path ~= "" then
                    vim.list_extend(bundles, vim.split(java_test_path, "\n"))
                end

                local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
                local lombok_path = jdtls_path .. "/lombok.jar"

                local config = {
                    capabilities = capabilities,
                    
                    init_options = {
                            bundles = bundles,
                            extendedClientCapabilities = extendedClientCapabilities,
                    },

                    cmd = {
                        vim.fn.stdpath("data") .. "/mason/bin/jdtls",
                        '--jvm-arg=-javaagent:' .. lombok_path,
                        '-data', workspace_dir   
                    },

                    root_dir = vim.fs.dirname(vim.fs.find({
                        'pom.xml', 'mvnw',
                        'build.gradle', 'build.gradle.kts', 'gradlew',
                        '.git'
                    }, { upward = true })[1]),

                    settings = {
                        java = {
                            signatureHelp = { enabled = true },
                            completion = {
                                favoriteStaticMembers = {
                                    "org.junit.jupiter.api.Assertions.*",
                                    "org.mockito.Mockito.*"
                                }
                            }
                        }
                    },

                    on_attach = function(client, bufnr)
                        local opts = { silent = true, buffer = bufnr }

                        vim.keymap.set('n', '<leader>jo', jdtls.organize_imports, { desc = "Organizar Imports", buffer = bufnr })
                        vim.keymap.set('n', '<leader>jv', jdtls.extract_variable, { desc = "Extraer Variable", buffer = bufnr })
                        vim.keymap.set('n', '<leader>jc', jdtls.extract_constant, { desc = "Extraer Constante", buffer = bufnr })
                        vim.keymap.set('n', '<leader>tc', jdtls.test_class, { desc = "Ejecutar Test de Clase", buffer = bufnr })
                        vim.keymap.set('n', '<leader>tm', jdtls.test_nearest_method, { desc = "Ejecutar Test Cercano", buffer = bufnr })

                        jdtls.setup_dap({ hotcodereplace = 'auto' })
                        require('jdtls.dap').setup_dap_main_class_configs()
                    end,               
                }

                jdtls.start_or_attach(config)
            end,
        })
    end,
}
