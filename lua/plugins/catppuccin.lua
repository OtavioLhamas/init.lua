return {
    {
        "catppuccin/nvim",
        opts = {
            term_colors = true,
            transparent_background = true,
            float = {
                solid = vim.o.winborder == "solid",
            },
            highlight_overrides = {
                mocha = function(mocha)
                    return {
                    }
                end,
            },
        },
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    },
}
