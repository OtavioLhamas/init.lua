return {
    'blink.cmp',
    dependencies = {
        "moyiz/blink-emoji.nvim",
    },
    opts = {
        cmdline = {
            completion = {
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    },
                },
                menu = { auto_show = true },
                ghost_text = { enabled = true },
            },
        },
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
            menu = {
                border = 'rounded',
                draw = {
                    columns = {
                        { 'item_idx' },
                        { 'kind_icon', 'kind', gap = 1 },
                        { 'label', 'label_description', gap = 1 },
                        { 'source_name' },
                    },
                    components = {
                        item_idx = {
                            text = function(ctx) return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx) end,
                            highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
                        },
                    }
                }
            },
            documentation = {
                window = {
                    border = 'rounded',
                },
            },
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning",
            sorts = {
                'exact',
                'score',
                'sort_text',
                'kind'
            }
        },
        keymap = {
            preset = 'default',
            ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
            ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
            ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
            ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
            ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
            ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
            ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
            ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
            ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
            ['<A-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
        },
        signature = {
            window = {
                border = 'rounded',
            },
        },
        -- sources = {
        --     default = {
        --         "emoji"
        --     },
        --     providers = {
        --         emoji = {
        --             module = "blink-emoji",
        --             name = "Emoji",
        --             score_offset = 15, -- Tune by preference
        --             opts = { insert = true }, -- Insert emoji (default) or complete its name
        --         }
        --     },
        -- }
    }
}
