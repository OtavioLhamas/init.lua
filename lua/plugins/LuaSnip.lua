return {
    "LuaSnip",
    opts = {
        updateevents = "TextChanged,TextChangedI",
    },
    keys = {
        {
            "<C-j>",
            function()
                if require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                end
            end,
            mode = { "i", "s" },
            silent = true,
        },
        {
            "<C-k>",
            function()
                if require("luasnip").jumpable(-1) then
                    require("luasnip").jump()
                end
            end,
            mode = { "i", "s" },
            silent = true,
        },
        {
            "<C-l>",
            function()
                if require("luasnip").choice_active() then
                    require("luasnip").change_choice(1)
                end
            end,
            mode = { "i", "s" },
            silent = true,
        },
    },
}
