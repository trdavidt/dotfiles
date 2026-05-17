return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        palette_overrides = {
          dark0_hard = "#181818",
          light1 = "#d8d8d8",
        },
        contrast = "hard",
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}
