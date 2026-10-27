vim.api.nvim_create_user_command("FormatProject", function()
    local files = vim.fn.globpath("src", "**/*.java", true, true)
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
