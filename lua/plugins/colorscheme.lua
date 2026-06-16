return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            variant = "main",
            dark_variant = "main",
            dim_inactive_windows = false,
            extend_background_behind_borders = false,
            styles = {
                bold = true,
                italic = false,
                transparency = true,
            },
            enable = {
                terminal = true,
                legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                migrations = true, -- Handle deprecated options automatically
            },
            highlight_groups = {
                ColorColumn = { bg = "#1C1C21" },
                -- Normal = { bg = "#000000" }, -- Main background remains transparent
                SnacksPickerBorder = { fg = "#9ccfd8", bg = "#191724" },
                NormalFloat = { bg = "base" },
                Pmenu = { bg = "#191724" }, -- Completion menu background
                PmenuSel = { bg = "#4a465d", fg = "NONE" }, -- Highlighted completion item
                FloatBorder = { bg = "base" },
                FloatTitle = { bg = "base" },
                PmenuSbar = { bg = "#191724" }, -- Scrollbar background
                PmenuThumb = { bg = "#9ccfd8" }, -- Scrollbar thumb
            },
        },
    },
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
                        SnacksPickerBorder = { fg = "#89DCEB", bg = "#181825" },

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
            colorscheme = "rose-pine",
        },
    },
}
