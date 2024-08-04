return {
    "project.nvim",
    opts = function(_, opts)
        opts.patterns = LazyVim.merge(opts.patterns or {}, {
            "*.sln",
            "package.json",
        })

        return opts
    end,
}
