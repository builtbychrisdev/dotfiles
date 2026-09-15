local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Write" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
map("n", "<leader>e", "<cmd>Ex<CR>", { desc = "File explorer" })

-- built-in finders
map("n", "<leader>f", ":find ", { desc = "Find file" })
map("n", "<leader>g", ":grep ", { desc = "Grep project" })
map("n", "<leader>b", ":buffer ", { desc = "Switch buffer" })

-- quickfix
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<CR>", { desc = "Prev quickfix" })

-- window nav
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- keep the cursor centred
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- move selected lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over a selection without losing the register
map("x", "<leader>p", [["_dP]])
