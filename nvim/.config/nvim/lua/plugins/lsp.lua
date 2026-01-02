return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    local caps =
      vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())
    local on_attach = function(_, _)
      vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP rename" })
      vim.keymap.set("n", "<leader>gh", vim.lsp.buf.hover, { desc = "LSP hover" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "LSP definition" })
      vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "LSP declaration" })
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "LSP format" })
      vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "LSP implementation" })
      vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "LSP typedef" })
      vim.keymap.set("n", "<leader>gq", vim.lsp.buf.references, { desc = "LSP references quickfix" })
      vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, { desc = "LSP references" })
      vim.keymap.set({ "n", "i" }, "<C-g>", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
    end

    local installed = {
      "lua_ls",
      "pyright",
      "clangd",
      "rust_analyzer",
      "ts_ls",
      "bashls",
    }
    for _, server_name in ipairs(installed) do
      vim.lsp.config(server_name, {
        capabilities = caps,
        on_attach = on_attach,
      })
    end

    -- Mason
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = installed,
    })

    -- Completions
    cmp.setup({
      mapping = {
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
