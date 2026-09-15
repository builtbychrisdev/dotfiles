-- leader must be set before anything maps against it
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("keymaps")

-- highlight text as you yank it
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    callback = function()
        vim.hl.on_yank({ timeout = 150 })
    end,
})

-- restore cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- everything in plugin/ loads automatically from here
