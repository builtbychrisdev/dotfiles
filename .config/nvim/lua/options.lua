local o = vim.o

-- appearance
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.scrolloff = 8
o.wrap = false
o.termguicolors = true
o.winborder = "rounded"
o.laststatus = 3

-- indentation
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
o.smartindent = true

-- search
o.ignorecase = true
o.smartcase = true
o.incsearch = true

-- files
o.undofile = true
o.swapfile = false
o.clipboard = "unnamedplus"
o.updatetime = 250
o.timeoutlen = 400

-- splits
o.splitright = true
o.splitbelow = true

-- built-in fuzzy command completion, no plugin needed
o.wildoptions = "pum,fuzzy"
o.completeopt = "menuone,noselect,popup"

-- use ripgrep for :grep
if vim.fn.executable("rg") == 1 then
    o.grepprg = "rg --vimgrep --smart-case"
    o.grepformat = "%f:%l:%c:%m"
end

-- :find searches recursively
o.path = ".,,**"
