return {
    "catppuccin/nvim",
    opts = {
        highlight_overrides = {
            mocha = function(mocha)
                return {
                    FloatBorder = {
                        bg = mocha.mantle
                    },

                    LazyNormal = {
                        bg = mocha.crust,
                    },

                    --#region NoiceCmdline
                    NoiceCmdlinePopup = {
                        bg = mocha.mantle,
                    },
                    NoiceCmdlinePopupBorder = {
                        bg = mocha.mantle,
                        -- fg = mocha.overlay0,
                    },
                    NoiceCmdlinePopupTitle = {
                        fg = mocha.subtext1,
                    },
                    --#endregion

                    --#region NoicePopup
                    NoicePopup = {
                        bg = mocha.mantle,
                    },
                    NoicePopupBorder = {
                        bg = mocha.mantle,
                        -- fg = mocha.overlay0,
                    },
                    NoicePopupTitle = {
                        fg = mocha.subtext1,
                    },
                    --#endregion

                    NormalFloat = {
                        bg = mocha.mantle,
                    },

                    --#region Notify
                    NotifyERRORBody = {
                        bg = mocha.mantle,
                    },
                    NotifyERRORBorder = {
                        bg = mocha.mantle,
                    },
                    NotifyWARNBody = {
                        bg = mocha.mantle,
                    },
                    NotifyWARNBorder = {
                        bg = mocha.mantle,
                    },
                    NotifyINFOBody = {
                        bg = mocha.mantle,
                    },
                    NotifyINFOBorder = {
                        bg = mocha.mantle,
                    },
                    NotifyDEBUGBody = {
                        bg = mocha.mantle,
                    },
                    NotifyDEBUGBorder = {
                        bg = mocha.mantle,
                    },
                    NotifyTRACEBody = {
                        bg = mocha.mantle,
                    },
                    NotifyTRACEBorder = {
                        bg = mocha.mantle,
                    },
                    --#endregion

                    NvimTreeNormal = {
                        bg = "NONE",
                    },

                    --#region Telescope
                    TelescopeNormal = {
                        bg = mocha.crust,
                    },
                    TelescopeBorder = {
                        bg = mocha.crust,
                        -- fg = mocha.overlay0,
                    },
                    TelescopePreviewNormal = {
                        bg = mocha.crust,
                    },
                    TelescopePreviewBorder = {
                        bg = mocha.crust,
                        -- fg = mocha.overlay0,
                    },
                    TelescopePromptNormal = {
                        bg = mocha.crust,
                    },
                    TelescopePromptBorder = {
                        bg = mocha.crust,
                        -- fg = mocha.overlay0,
                    },
                    TelescopePromptTitle = {
                        fg = mocha.subtext1,
                    },
                    TelescopeResultsNormal = {
                        bg = mocha.base,
                    },
                    TelescopeResultsBorder = {
                        bg = mocha.base,
                        -- fg = mocha.overlay0,
                    },
                    --#endregion

                    WhichKeyTitle = {
                        bg = mocha.mantle
                    }
                }
            end,
        },
        integrations = {
            navic = { enabled = true, custom_bg = "NONE" },
        },
        term_colors = true,
        transparent_background = true,
    },
}
