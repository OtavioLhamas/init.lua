return {
    "blink.cmp",
    opts = {
        --#region cmdline
        cmdline = {
            completion = {
                list = {
                    selection = {
                        auto_insert = true,
                        preselect = false,
                    },
                },
            },
            sources = { "buffer", "cmdline", "path" },
        },
        --#endregion

        --#region Completion menu behaviour
        completion = {
            list = {
                selection = {
                    auto_insert = false,
                    preselect = false,
                },
            },
            menu = {
                draw = { -- controls the completion menu appearance
                    columns = {
                        { "kind_icon" },
                        { "label", "label_description", gap = 1 },
                        { "item_idx" },
                    },
                    components = { -- custom menu components
                        item_idx = {
                            highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
                            text = function(ctx)
                                return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
                            end,
                        },
                    },
                },
                max_height = 15,
            },
        },
        --#endregion

        --#region Fuzzy finding rules
        fuzzy = {
            implementation = "prefer_rust_with_warning",
            sorts = {
                "exact",
                "score",
                "sort_text",
                "kind",
            },
        },
        --#endregion

        --#region Keymaps
        keymap = {
            ["<A-1>"] = {
                function(cmp)
                    cmp.accept({ index = 1 })
                end,
            },
            ["<A-2>"] = {
                function(cmp)
                    cmp.accept({ index = 2 })
                end,
            },
            ["<A-3>"] = {
                function(cmp)
                    cmp.accept({ index = 3 })
                end,
            },
            ["<A-4>"] = {
                function(cmp)
                    cmp.accept({ index = 4 })
                end,
            },
            ["<A-5>"] = {
                function(cmp)
                    cmp.accept({ index = 5 })
                end,
            },
            ["<A-6>"] = {
                function(cmp)
                    cmp.accept({ index = 6 })
                end,
            },
            ["<A-7>"] = {
                function(cmp)
                    cmp.accept({ index = 7 })
                end,
            },
            ["<A-8>"] = {
                function(cmp)
                    cmp.accept({ index = 8 })
                end,
            },
            ["<A-9>"] = {
                function(cmp)
                    cmp.accept({ index = 9 })
                end,
            },
            ["<A-0>"] = {
                function(cmp)
                    cmp.accept({ index = 10 })
                end,
            },
        },
        --#endregion
    },
}
