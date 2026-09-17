local M = {}

function M.capabilities()
    local caps = require("blink.cmp").get_lsp_capabilities()
    local ok, file_ops = pcall(require, "lsp-file-operations")
    if ok then
        caps = vim.tbl_deep_extend("force", caps, file_ops.default_capabilities())
    end
    return caps
end

return M
