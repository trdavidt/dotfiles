return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            highlights = {
                background = {
                    guibg = '#0d1117',
                },
            },
        })
        vim.keymap.set("n", "<leader>br", "<Cmd>BufferLineCloseRight<cr>", { desc = "delete buffers to right" })
        vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<cr>", { desc = "delete buffers to left" })
        -- vim.cmd([[
        --   augroup MyColors
        --   autocmd!
        --   autocmd ColorScheme * highlight BufferLineFill guibg=#0D1117
        --   augroup END
        -- ]])
    end,
}
