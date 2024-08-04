return {
    "edgy.nvim",
    opts = function(_, opts)
        opts.animate = LazyVim.merge(opts.animate, {
            enbaled = false,
        })

        return opts
    end,
}
