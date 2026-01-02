return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      show_hidden = true,
      -- is_hidden_file = function(name, bufnr)
      --   return name ~= ".." and vim.startswith(name, ".")
      -- end,
    },
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
    },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  keys = {
    { "<leader>o", "<cmd>Oil<cr>", { desc = "Oil toggle", remap = true } },
  },
}
