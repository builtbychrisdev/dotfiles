vim.pack.add({
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
})

require("gruvbox").setup({
    terminal_colors = true,
    contrast = "hard",
    transparent_mode = true,
    inverse = true,
    italic = { strings = false, comments = true, folds = true },
})

vim.cmd.colorscheme("gruvbox")
