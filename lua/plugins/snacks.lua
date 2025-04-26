return {
    {
        "snacks.nvim",
        keys = {
            { "<leader>sz", function() Snacks.picker.zoxide() end, desc = "Zoxide" },
        },
        opts = {
            animate = { enabled = false },
            indent = {
                scope = {
                    hl = {
                        "SnacksIndent1",
                        "SnacksIndent2",
                        "SnacksIndent3",
                        "SnacksIndent4",
                        "SnacksIndent5",
                        "SnacksIndent6",
                        "SnacksIndent7",
                        "SnacksIndent8",
                    },
                },
            },
            picker = {
                layouts = {
                    select_colorscheme = {
                        layout = {
                            relative = 'cursor',
                            width = 0.4,
                            min_width = 0,
                            row = 1,
                            backdrop = false,
                            height = 0.5,
                            min_height = 3,
                            box = "vertical",
                            border = "rounded",
                            title = "{title}",
                            title_pos = "center",
                            { win = "input", height = 1, border = "bottom" },
                            { win = "list", border = "none" },
                            { win = "preview", title = "{preview}", height = 0.2, border = "top" },
                        },
                    },
                },
                sources = {
                    colorschemes = {
                        layout = {
                            preset = 'select_colorscheme',
                            preview = 'colorscheme'
                        },
                    },
                    command_history = {
                        layout = {
                            preview = false,
                            preset = "dropdown"
                        },
                    },
                    diagnostics_buffer = {
                        -- Same as Snacks.picker.format.diagnostic(), but removes the file name at the end
                        format = function (item, picker)
                            local ret = {} ---@type snacks.picker.Highlight[]
                            local diag = item.item ---@type vim.Diagnostic
                            if item.severity then
                                vim.list_extend(ret, Snacks.picker.format.severity(item, picker))
                            end

                            local message = diag.message
                            ret[#ret + 1] = { message }
                            Snacks.picker.highlight.markdown(ret)
                            ret[#ret + 1] = { " " }

                            if diag.source then
                                ret[#ret + 1] = { diag.source, "SnacksPickerDiagnosticSource" }
                                ret[#ret + 1] = { " " }
                            end

                            if diag.code then
                                ret[#ret + 1] = { ("(%s)"):format(diag.code), "SnacksPickerDiagnosticCode" }
                                ret[#ret + 1] = { " " }
                            end
                            return ret
                        end,
                    },
                    explorer = {
                        hidden = true,
                        ignored = true,
                        win = {
                            list = {
                                wo = {
                                    relativenumber = true
                                }
                            }
                        }
                    },
                    files = {
                        hidden = true,
                        ignored = true
                    },
                    lsp_workspace_symbols = {
                        formatters = {
                            file = {
                                filename_first = true
                            }
                        }
                    },
                }
            },
            scroll = { enabled = false },
        }
    }
}
