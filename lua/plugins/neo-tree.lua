return {
    "neo-tree.nvim",
    init = function()
        vim.g.neotree = {
            auto_open = false,
        }
    end,
    opts = function(_, opts)
        opts.sources = { "filesystem" }

        return opts
    end,
}
