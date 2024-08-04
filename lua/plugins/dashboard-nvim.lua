return {
    "dashboard-nvim",
    opts = function(_, opts)
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("Dashboard_start_directory", { clear = true }),
            desc = "Start Dashboard find_files with directory",
            once = true,
            callback = function()
                local stats = vim.uv.fs_stat(vim.fn.argv(0))
                if stats and stats.type == "directory" then
                    vim.schedule(function()
                        vim.api.nvim_exec2("Dashboard", {})
                        vim.api.nvim_exec2("lua LazyVim.pick()()", {})
                    end)
                end
            end,
        })

        -- add persistence select() after load()
        for key, value in pairs(opts.config.center) do
            if value.action == 'lua require("persistence").load()' then
                table.insert(opts.config.center, key + 1, {
                    action = 'lua require("persistence").select()',
                    desc = " Select Sessions",
                    icon = " ",
                    key = "S",
                })
            end
        end

        for _, button in ipairs(opts.config.center) do
            button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
            button.key_format = "  %s"
        end

        return opts
    end,
}
