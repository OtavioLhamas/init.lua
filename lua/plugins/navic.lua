return {
    {
        "SmiteshP/nvim-navic",
        opts = function(_, opts)
            opts = vim.tbl_deep_extend("force", opts, {
                depth_limit = 0,
                depth_limit_indicator = "..",
                safe_output = true,
                separator = " > ",
                click = true,
            })

            return opts
        end,
    },
}
