return {
    "which-key.nvim",
    opts = function(_, opts)

        local border = require("util").icons.border
        opts.preset = "modern"
        opts.win = LazyVim.merge(opts.win, {
            border = {
                border.thin.top_left,
                border.thin.top,
                border.thin.top_right,
                border.thin.right,
                border.thin.bottom_right,
                border.thin.bottom,
                border.thin.bottom_left,
                border.thin.left,
            },
        })
    end,
}
