return {
    "noice.nvim",
    --TODO: come back here to config inc-rename.nvim once it is enabled
    opts = {
        cmdline = {
            view = "cmdline",
        },
        presets = {
            bottom_search = true,
            command_pallete = false,
            inc_rename = {
                cmdline = {
                    format = {
                        IncRename = {
                            opts = {
                                position = {
                                    col = 0,
                                    row = -3,
                                },
                                relative = "cursor",
                                size = {
                                    min_width = 20,
                                },
                            },
                            -- this allows me to keep IncRename relative to the cursor,
                            -- and a classic cmdline at the same time
                            view = "cmdline_popup",
                        },
                    },
                },
            },
            lsp_doc_border = true,
        },
    },
}
