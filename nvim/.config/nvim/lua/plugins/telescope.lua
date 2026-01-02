return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
    { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
    { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "Telescope LSP references" },
    -- { "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", desc = "Telescope LSP impls" },
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Telescope LSP symbols" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Telescope grep word" },
    { "<leader>fc", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Telescope colorscheme" },
  },
}
