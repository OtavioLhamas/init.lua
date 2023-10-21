return {
    {
        "ahmedkhalf/project.nvim",
        opts = function (_, opts)
            opts.patterns = vim.list_extend(opts.patterns or {}, {
                ".git",
                "*.sln",
                "Makefile",
                "package.json"
            })

            return opts
        end

    }
}
