vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.lsp.enable({ "lua_ls", "html", "cssls", "ts_ls", "jsonls" })

vim.diagnostic.config({
    virtual_text = { prefix = "●" },
    severity_sort = true,
    underline = true,
    float = { border = "rounded", source = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("K", vim.lsp.buf.hover, "Hover docs")
        map("<leader>d", vim.diagnostic.open_float, "Line diagnostics")
        map("<leader>F", function() vim.lsp.buf.format({ async = true }) end, "Format")

        -- autocomplete as you type, no cmp plugin
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
            autotrigger = true,
        })
    end,
})
