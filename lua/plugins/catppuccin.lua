return {
    {
        "catppuccin/nvim",
        opts = {
            term_colors = true,
            transparent_background = true,
            highlight_overrides = {
                mocha = function(mocha)
                    return {
                        BlinkCmpMenu = {
                            link = "NormalFloat"
                        },
                        BlinkCmpMenuBorder = {
                            link = "NormalFloat"
                        },
                        BlinkCmpSource = {
                            link = "NormalFloat"
                        },
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
