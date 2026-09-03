local map = vim.keymap.set
local opts = { noremap= true, silent= true}

-- Copied, pasted and selected
map({"n","x"}, "cp", '"+y', opts)
map({"n","x"}, "cv", '"+p', opts)
map({"n","x"}, "x", '"_x', opts)
map("n", "<leader>a", "<cmd>keepjumps normal! ggVG<cr>", opts)

-- Buffer Control
map("n", "<Tab>", "<cmd>bnext<cr>")
map("n", "<S-Tab>", "<cmd>bprevious<cr>")
map("n", "<leader>bc", "<cmd>bd!<cr>", opts)
map("n", "<leader>bs", "<cmd>w | bd<cr>", opts)

-- Line operations
map("n", "<leader>d", "<cmd>copy .<cr>", opts)                    -- Duplicate line
map("v", "<C-j>", ":move '>+1<cr>gv", opts)                     -- Move lines down (visual)
map("v", "<C-k>", ":move '<-2<cr>gv", opts)                     -- Move lines up (visual)
map("n", "<C-j>", ":move .+1<cr>", opts)                        -- Move line down (normal)
map("n", "<C-k>", ":move .-2<cr>", opts)                        -- Move line up (normal)

-- Search and select
map("n", "<leader>s", "v<C-$>", opts)                           -- Select to end of line
map("n", "<leader>sl", "^v$h", opts)                            -- Select entire line

-- Formatting
map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format()<cr>", opts) -- Format document
