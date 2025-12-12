local map = vim.keymap.set
local opts = { noremap= true, silent= true}

-- copied, pasted and selected
map({"n","x"}, "cp", '"+y', opts)
map({"n","x"}, "cv", '"+p', opts)
map({"n","x"}, "x", '"_x', opts)
map("n", "<leader>a", "<cmd>keepjumps normal! ggVG<cr>", opts)

-- Buffer Control
map("n", "<Tab>", "<cmd>bnext<cr>")
map("n", "<S-Tab>", "<cmd>bprevious<cr>")
map("n", "<leader>bc", "<cmd>bd!<cr>", opts)
map("n", "<leader>bs", "<cmd>w | bd<cr>", opts)
