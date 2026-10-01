local M = {}

function M.capabilities()
    return vim.tbl_deep_extend("force",
        require("blink.cmp").get_lsp_capabilities(),
        require("nvim-file-operations.config").default_capabilities()
    )
end

return M
