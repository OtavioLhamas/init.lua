return {
    "nvim-navic",
    opts = function(_, opts)
        opts = LazyVim.merge(opts, {
            depth_limit = 0,
            depth_limit_indicator = "..",
            separator = " > ",
            click = true,
        })

        return opts
    end,
}
