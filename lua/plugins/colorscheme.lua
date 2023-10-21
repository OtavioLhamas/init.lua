return {
    {
        "catppuccin",
        opts = function(_, opts)
            opts = vim.tbl_deep_extend("force", opts, {
                flavour = "mocha",
                background = {
                    light = "latte",
                    dark = "mocha",
                },
                highlight_overrides = {
                    mocha = function(mocha)
                        return {
                            LazyNormal = {
                                bg = mocha.crust,
                            },

                            NoiceCmdlinePopup = {
                                bg = mocha.mantle,
                            },
                            NoiceCmdlinePopupBorder = {
                                bg = mocha.mantle,
                                fg = mocha.overlay0,
                            },
                            NoiceCmdlinePopupTitle = {
                                fg = mocha.subtext1,
                            },

                            NoicePopup = {
                                bg = mocha.mantle,
                            },
                            NoicePopupBorder = {
                                bg = mocha.mantle,
                                fg = mocha.overlay0,
                            },
                            NoicePopupTitle = {
                                fg = mocha.subtext1,
                            },

                            NotifyBackground = {
                                bg = mocha.mantle,
                            },

                            NvimTreeNormal = {
                                bg = "NONE",
                            },

                            NormalFloat = {
                                bg = mocha.mantle,
                            },

                            TelescopeNormal = {
                                bg = mocha.crust,
                            },
                            TelescopeBorder = {
                                bg = mocha.crust,
                                fg = mocha.overlay0,
                            },
                            TelescopePreviewNormal = {
                                bg = mocha.crust,
                            },
                            TelescopePreviewBorder = {
                                bg = mocha.crust,
                                fg = mocha.overlay0,
                            },
                            TelescopePromptNormal = {
                                bg = mocha.crust,
                            },
                            TelescopePromptBorder = {
                                bg = mocha.crust,
                                fg = mocha.overlay0,
                            },
                            TelescopePromptTitle = {
                                fg = mocha.subtext1,
                            },
                            TelescopeResultsNormal = {
                                bg = mocha.base,
                            },
                            TelescopeResultsBorder = {
                                bg = mocha.base,
                                fg = mocha.overlay0,
                            },
                        }
                    end,
                },
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15,
                },
                integrations = {
                    treesitter_context = true,
                    navic = { enabled = true, custom_bg = "NONE" },
                    telescope = { enabled = true },
                    trouble = false,
                    ufo = true,
                },
                term_colors = true,
                transparent_background = true,
            })

            return opts
        end,
    },
}
