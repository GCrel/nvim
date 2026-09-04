return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    config = function()
        require("ibl").setup()
    end
}
