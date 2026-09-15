vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("nvim-treesitter").install({
    "html", "css", "javascript", "typescript", "json", "bash", "yaml",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "javascript", "typescript", "json", "bash", "yaml" },
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
