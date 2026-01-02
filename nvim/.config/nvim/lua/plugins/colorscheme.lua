return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        palette_overrides = {
          light1 = "#d4d4d4",
          bg0 = "#1f1f1f",
        },
        contrast = "hard",
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}
