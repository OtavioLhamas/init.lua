return {
    "snacks.nvim",
    keys = {
        {
            "<leader>sz",
            function()
                Snacks.picker.zoxide()
            end,
            desc = "Zoxide",
        },
    },
    opts = {

        animate = { enabled = false },

        explorer = {
            replace_netrw = false, -- don't auto open when starting nvim with a directory
        },

        --#region Image preview
        image = {
            -- TODO: test on linux
            enabled = not LazyVim.is_win(), -- doesn't work with WezTerm on Windows 11
        },
        --#endregion

        --#region Indent guides and scopes
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
                    "SnacksIndent9",
                },
            },
        },
        --#endregion

        --#region Picker
        picker = {
            --#region Picker custom layouts
            layouts = {
                select_colorscheme = {
                    layout = {
                        relative = "cursor",
                        width = 0.4,
                        min_width = 0,
                        row = 1,
                        backdrop = false,
                        height = 0.5,
                        min_height = 3,
                        box = "vertical",
                        title = "{title}",
                        title_pos = "center",
                        { win = "input", height = 1, border = "bottom" },
                        { win = "list", border = "none" },
                        { win = "preview", title = "{preview}", height = 0.2, border = "top" },
                    },
                },
            },
            --#endregion

            --#region Picker sources
            sources = {
                colorschemes = {
                    layout = {
                        preset = "select_colorscheme",
                        preview = "colorscheme",
                    },
                },
                command_history = {
                    layout = {
                        preview = false,
                        preset = "dropdown",
                    },
                },
                explorer = {
                    hidden = true,
                    ignored = true,
                    win = {
                        list = {
                            wo = {
                                relativenumber = true,
                            },
                        },
                    },
                },
                files = {
                    hidden = true,
                    ignored = true,
                },
            },
            --#endregion
        },
        --#endregion

        scroll = { enabled = false },
    },
}
