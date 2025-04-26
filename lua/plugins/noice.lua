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
                position = {
                    col = 0,
                    row = 2,
                },
                relative = "cursor",
                size = {
                    min_width = 20,
                },
            },
            -- this allows me to keep IncRename relative to the cursor,
            -- and a classic cmdline at the same time
            view = "cmdline_popup",
        })

        opts.presets = LazyVim.merge(opts.presets, {
            bottom_search = true,
            command_palette = false,
            lsp_doc_border = true,
            inc_rename = true,
        })

    end,
}

