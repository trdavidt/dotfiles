-- editor
vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>ex", vim.cmd.Ex, { desc = "netrw" })
vim.keymap.set("n", "<C-_>", 'gcc', { desc = "comment line", remap = true })
vim.keymap.set("v", "<C-_>", 'gc', { desc = "comment lines", remap = true })
vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'search and replace word' })

-- buffer
vim.keymap.set("n", "<leader>bd", vim.cmd.bd, { desc = "delete buffer" })
vim.keymap.set("n", "<leader>bb", vim.cmd.bnext, { desc = "next buffer" })
vim.keymap.set("n", "<leader>bp", vim.cmd.bprev, { desc = "prev buffer" })

-- quickfix list
vim.keymap.set("n", "<leader>ql", "<cmd>clist<cr>", { desc = "quickfix list open" })
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<cr>", { desc = "quickfix list close" })
vim.keymap.set("n", "<leader>qn", "<cmd>cnext<cr>", { desc = "next quickfix" })
vim.keymap.set("n", "<leader>qp", "<cmd>cprev<cr>", { desc = "prev quickfix" })
vim.keymap.set("n", "<leader>qs", [[:cdo s//gc<Left><Left><Left>]], { desc = "quickfix search and replace" })
