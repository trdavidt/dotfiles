--- editor options
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.termguicolors = true

--- session save
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,winpos,localoptions"

--- shared clipboard
vim.api.nvim_set_option("clipboard", "unnamedplus")

--- autocmd groups
local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end
chore_group = augroup("chore")
persistence_group = augroup("session")

-- restore the session for the current directory
-- vim.api.nvim_create_autocmd("VimEnter", {
--     group = persistence_group,
--     callback = function()
--         require("persistence").load()
--         vim.notify("loaded session")
--     end,
--     nested = true,
-- })

--- auto-update LazyVim plugins
vim.api.nvim_create_autocmd("VimEnter", {
    group = chore_group,
    callback = function()
        if require("lazy.status").has_updates() then
            require("lazy").update({ show = false, })
        -- else
        --     vim.notify("lazyvim up to date")
        end
    end,
})

-- cleanup old session files outside of 5 latest
vim.api.nvim_create_autocmd("VimEnter", {
    group = chore_group,
    callback = function()
        local state_dir = vim.fn.expand("~/.local/state/nvim/sessions")
        local files = vim.fn.readdir(state_dir)

        --- session file names and times, newest to oldest
        local file_info = {}
        for _, file in ipairs(files) do
            local filepath = state_dir .. "/" .. file
            local stat = vim.loop.fs_stat(filepath)
            if stat and stat.type == "file" then
                table.insert(file_info, { name = file, mtime = stat.mtime.sec })
            end
        end
        table.sort(file_info, function(a, b)
            return a.mtime > b.mtime
        end)

        -- remove session files after 5 newest
        local removed_files = {}
        for i = 6, #file_info do
            local filepath = state_dir .. "/" .. file_info[i].name
            local ok = os.remove(filepath)
            if ok then
                table.insert(removed_files, file_info[i].name)
            end
        end
        if #removed_files > 0 then
            vim.notify("removed sessions: " .. table.concat(removed_files, "\n"))
            -- else
            --     vim.notify("no sessions removed")
        end
    end
})
