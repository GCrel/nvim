return {
  "akinsho/toggleterm.nvim",
  version = "*",

  keys = {
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal Horizontal" },

    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Flotante" },
  },

  config = function()
    require("toggleterm").setup {
      size = function(term)
        if term.direction == "horizontal" then
          return 10
        elseif term.direction == "float" then
          return vim.o.columns * 0.5
        end
      end,
      border = "shadow",
      shade_terminals = false,
      shell = "zsh", -- shell preference
    }
  end,
}

