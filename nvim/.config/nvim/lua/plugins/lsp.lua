return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local luasnip = require("luasnip")
        local caps = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )
        local on_attach = function(_, _)
            vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = "LSP rename" })
            vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, { desc = "LSP hover" })
            vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = "LSP format" })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP code action" })
            vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = "LSP definition" })
            vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, { desc = "LSP implementation" })
            vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, { desc = "LSP typedef" })
            vim.keymap.set('n', '<leader>gq', vim.lsp.buf.references, { desc = "LSP references quickfix" })
            vim.keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references, { desc = "LSP references" })
            vim.keymap.set({ 'n', 'i' }, '<C-g>', vim.lsp.buf.signature_help, { desc = "LSP signature help" })
        end
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "clangd",
            },
            handlers = {
                function(server_name) -- default handler
                    require("lspconfig")[server_name].setup {
                        capabilities = caps,
                        on_attach = on_attach,
                    }
                end,
            }
        })
        -- require("lspconfig").lua_ls.setup({
        --     on_attach = on_attach
        -- })
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            -- mapping = vim.tbl_extend("force", cmp.mapping.preset, {
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- they way you will only jump inside the snippet region
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }),
        })
    end,
    opts = function(_, opts)
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local cmp = require("cmp")
        local luasnip = require("luasnip")
        opts.mapping = vim.tbl_extend("force", {}, {
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
                    cmp.select_next_item()
                elseif vim.snippet.active({ direction = 1 }) then
                    vim.schedule(function()
                        vim.snippet.jump(1)
                    end)
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif vim.snippet.active({ direction = -1 }) then
                    vim.schedule(function()
                        vim.snippet.jump(-1)
                    end)
                else
                    fallback()
                end
            end, { "i", "s" }),
        })
    end,
}
