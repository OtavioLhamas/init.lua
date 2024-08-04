return {
    "noice.nvim",
    opts = function(_, opts)
        opts.cmdline = {
            view = "cmdline",
        }

        -- customize the inc-rename.nvim window
        table.insert(opts.routes, {
            filter = {
                event = "cmdline",
                kind = "IncRename",
            },
            opts = {
                border = {
                    text = {
                        top = " IncRename ",
                    },
                },
                position = {
                    col = 0,
                    row = -3,
                },
                relative = "cursor",
                size = {
                    min_width = 20,
                },
                win_options = {
                    winhighlight = {
                        FloatBorder = "NoiceCmdlinePopupBorderIncRename",
                        FloatTitle = "NoiceCmdlinePopupTitleIncRename",
                    },
                },
            },
            -- this allows me to keep IncRename relative to the cursor,
            -- and a classic cmdline at the same time
            view = "cmdline_popup",
        })

        opts.presets = LazyVim.merge(opts.presets, {
            bottom_search = true,
            command_palette = true,
            lsp_doc_border = true,
            inc_rename = true,
        })

        local borders = require("util").icons.border

        opts.views = LazyVim.merge(opts.views, {
            -- TODO investigate how to customize notify popup colors
            cmdline_popup = {
                border = {
                    style = {
                        borders.thin.top_left,
                        borders.thin.top,
                        borders.thin.top_right,
                        borders.thin.right,
                        borders.thin.bottom_right,
                        borders.thin.bottom,
                        borders.thin.bottom_left,
                        borders.thin.left,
                    },
                },
            },
            hover = {
                border = {
                    style = {
                        borders.thin.top_left,
                        borders.thin.top,
                        borders.thin.top_right,
                        borders.thin.right,
                        borders.thin.bottom_right,
                        borders.thin.bottom,
                        borders.thin.bottom_left,
                        borders.thin.left,
                    },
                },
            },
            popup = {
                border = {
                    style = {
                        borders.thin.top_left,
                        borders.thin.top,
                        borders.thin.top_right,
                        borders.thin.right,
                        borders.thin.bottom_right,
                        borders.thin.bottom,
                        borders.thin.bottom_left,
                        borders.thin.left,
                    },
                },
            },
            popupmenu = {
                border = {
                    style = {
                        borders.thin.top_left,
                        borders.thin.top,
                        borders.thin.top_right,
                        borders.thin.right,
                        borders.thin.bottom_right,
                        borders.thin.bottom,
                        borders.thin.bottom_left,
                        borders.thin.left,
                    },
                },
            },
        })
    end,
}
