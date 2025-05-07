return {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
        require("persistence").setup({
            dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
            -- minimum number of file buffers that need to be open to save
            -- Set to 0 to always save
            need = 1,
            branch = false, -- use git branch to save session
            -- add any custom options here
        })
        -- restore the session for the current directory
        vim.keymap.set("n", "<leader>sr", function() require("persistence").load() end, { desc = "load session for cwd"})
        -- select a session to load
        vim.keymap.set("n", "<leader>ss", function() require("persistence").select() end, {desc = "select session" })
        -- load the last session
        vim.keymap.set("n", "<leader>sl", function() require("persistence").load({ last = true }) end, {desc = "load previous session"})
        -- stop Persistence => session won't be saved on exit
        vim.keymap.set("n", "<leader>sd", function() require("persistence").stop() end, {desc = "disable session save for cwd"})
    end,
}
