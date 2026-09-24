return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    ft = { "markdown", "markdown_inline", "md" },
    config = function()
        require('render-markdown').setup({
            completions = { lsp = { enabled = true } },
            image = {
                enabled = true,
            },
        })
    end
}
