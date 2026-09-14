local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.wrap = false
opt.linebreak = true

-- Tabs / indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- Files
opt.fileencoding = "utf-8"
opt.undofile = true
opt.swapfile = true

-- Behavior
opt.mouse = "a"
opt.scrolloff = 3
opt.sidescrolloff = 3
opt.updatetime = 250
opt.splitbelow = true
opt.splitright = true
opt.showmode = false

-- Wildmenu
opt.wildmode = "longest:full,full"

-- Performance
opt.timeoutlen = 400
opt.completeopt = "menuone,noselect"
opt.pumheight = 10

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
