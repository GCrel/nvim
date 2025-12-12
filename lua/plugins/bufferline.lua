return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",

  event = "VeryLazy",

  opts = {
    options = {
      mode = "buffers",
      numbers = "none",
      diagnostics = "nvim_lsp",

      separator_style = "slant",

      show_buffer_close_icons = false,
      show_close_icon = false,
      color_icons = true,
      enforce_regular_tabs = false,
      always_show_bufferline = true,

      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true,
        },
      },
    },
  },
}

