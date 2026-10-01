return {
    'MeanderingProgrammer/render-markdown.nvim',
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    ft = { "markdown", "markdown_inline", "md" },
    config = function()
        require('render-markdown').setup({
            completions = { lsp = { enabled = true } },
        })
    end
}
