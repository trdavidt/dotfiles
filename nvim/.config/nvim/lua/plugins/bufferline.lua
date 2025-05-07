return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    -- keys = {
    --  { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to right" },
    --  { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to left" },
    --  { "<leader>bj>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    --  { "<leader>bk>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    -- },
    config = function()
        require("bufferline").setup({
            highlights = {
                background = {
                    guibg = '#0d1117',
                },
            },
        })
        vim.keymap.set("n", "<leader>br", "<Cmd>BufferLineCloseRight<cr>", { desc = "Delete buffers to right" })
        vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<cr>", { desc = "Delete buffers to left" })
        -- vim.cmd([[
        --   augroup MyColors
        --   autocmd!
        --   autocmd ColorScheme * highlight BufferLineFill guibg=#0D1117
        --   augroup END
        -- ]])
    end,
}
