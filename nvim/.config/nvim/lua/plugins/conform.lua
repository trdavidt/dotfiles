return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>bf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "format buffer",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      go = { "gofmt" },
      c = { "clang-format" },
      sh = { "shfmt" },
      rust = { "rustfmt" },
      html = { "prettier" },
      css = { "prettier" },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500 },
    -- Customize formatters
    -- formatters = {
    --   stylua = {
    --     append_args = {
    --       "--indent-type",
    --       "Spaces",
    --       "--indent-width",
    --       "2",
    --     },
    --   },
    -- },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
