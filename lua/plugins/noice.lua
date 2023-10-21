return {
    {
        "folke/noice.nvim",
        opts = function(_, opts)
            opts.lsp = vim.tbl_deep_extend("force", opts.lsp, {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                    ["vim.lsp.util.stylize_markdown"] = false,
                    ["cmp.entry.get_documentation"] = true,
                },
            })

            opts.presets = vim.tbl_deep_extend("force", opts.presets, {
                lsp_doc_border = true,
            })

            local borders = require("lazyvim.config").icons.borders

            opts.views = {
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
            }

            opts.commands = {
                history = {
                    view = "split",
                    filter_opts = { reverse = true },
                    opts = { enter = true },
                },
            }

            return opts
        end,
    },
    {
        "rcarriga/nvim-notify",
        opts = function(_, opts)
            local icons = require("lazyvim.config").icons
            opts.icons = {
                DEBUG = icons.diagnostics.Debug,
                ERROR = icons.diagnostics.Error,
                INFO = icons.diagnostics.Info,
                TRACE = icons.diagnostics.Hint,
                WARN = icons.diagnostics.Warn,
            }

            return opts
        end,
    },
}
