return {
    {
        "catppuccin/nvim",
        opts = {
            flavour = "mocha",
            float = {
                solid = vim.o.winborder == "solid",
            },
            highlight_overrides = {
                mocha = function(colors)
                    return {
                        SnacksNotifierDebug = { fg = "#FAB387", bg = "#181825" },
                        SnacksNotifierError = { fg = "#F38BA8", bg = "#181825" },
                        SnacksNotifierTrace = { fg = "#F5E0DC", bg = "#181825" },
                        SnacksNotifierInfo = { fg = "#89B4FA", bg = "#181825" },
                        SnacksNotifierWarn = { fg = "#F9E2AF", bg = "#181825" },
                        SnacksNotifierIconDebug = { fg = "#FAB387", bg = "#181825" },
                        SnacksNotifierIconError = { fg = "#F38BA8", bg = "#181825" },
                        SnacksNotifierIconTrace = { fg = "#F5E0DC", bg = "#181825" },
                        SnacksNotifierIconInfo = { fg = "#89B4FA", bg = "#181825" },
                        SnacksNotifierIconWarn = { fg = "#F9E2AF", bg = "#181825" },
                        SnacksNotifierTitleDebug = { fg = "#FAB387", bg = "#181825" },
                        SnacksNotifierTitleError = { fg = "#F38BA8", bg = "#181825" },
                        SnacksNotifierTitleTrace = { fg = "#F5E0DC", bg = "#181825" },
                        SnacksNotifierTitleInfo = { fg = "#89B4FA", bg = "#181825" },
                        SnacksNotifierTitleWarn = { fg = "#F9E2AF", bg = "#181825" },
                        SnacksNotifierBorderDebug = { fg = "#FAB387", bg = "#181825" },
                        SnacksNotifierBorderError = { fg = "#F38BA8", bg = "#181825" },
                        SnacksNotifierBorderTrace = { fg = "#F5E0DC", bg = "#181825" },
                        SnacksNotifierBorderInfo = { fg = "#89B4FA", bg = "#181825" },
                        SnacksNotifierBorderWarn = { fg = "#F9E2AF", bg = "#181825" },
                    }
                end,
            },
            term_colors = true,
            transparent_background = true,
        },
    },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    },
}
