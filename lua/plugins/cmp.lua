local source_names = {
    buffer = "(Buffer)",
    emoji = "(Emoji)",
    luasnip = "(Snippet)",
    nvim_lsp = "(LSP)",
    path = "(Path)",
    treesitter = "(TreeSitter)",
}

local cmp_sources = {
    { name = "buffer", priority = 6 },
    { name = "emoji" },
    { name = "luasnip", priority = 8 },
    {
        name = "nvim_lsp",
        entry_filter = function(entry, ctx)
            local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
            if kind == "Text" then
                return false
            end
            return true
        end,
        priority = 9,
    },
    { name = "path", priority = 7 },
    { name = "treesitter", priority = 8 },
}

return {
    {
        "L3MON4D3/LuaSnip",
        keys = {
            { "<tab>", false, mode = "i" },
            { "<tab>", false, mode = "s" },
            { "<s-tab>", false, mode = { "i", "s" } },
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
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-cmdline", keys = { ":", "/", "?" } },
            { "hrsh7th/cmp-emoji" },
        },
        opts = function(_, opts)
            local cmp = require("cmp")
            local icons = require("lazyvim.config").icons
            opts = vim.tbl_deep_extend("force", opts, {
                completion = {
                    completeopts = "menu,menuone,noinsert,noselect",
                    keyword_length = 1,
                },
                formatting = {
                    format = function(entry, item)
                        if icons.kinds[item.kind] then
                            item.kind = icons.kinds[item.kind] .. " " .. item.kind
                        end
                        item.menu = source_names[entry.source.name]
                        return item
                    end,
                },
                preselect = cmp.PreselectMode.None,
                sorting = {
                    comparators = {
                        cmp.config.compare.score,
                        cmp.config.compare.order,
                        cmp.config.compare.locality,
                        cmp.config.compare.recently_used,
                    },
                },
                sources = cmp.config.sources(cmp_sources),
                window = {
                    completion = {
                        border = {
                            icons.borders.thin.top_left,
                            icons.borders.thin.top,
                            icons.borders.thin.top_right,
                            icons.borders.thin.right,
                            icons.borders.thin.bottom_right,
                            icons.borders.thin.bottom,
                            icons.borders.thin.bottom_left,
                            icons.borders.thin.left,
                        },
                    },
                    documentation = {
                        border = {
                            icons.borders.thin.top_left,
                            icons.borders.thin.top,
                            icons.borders.thin.top_right,
                            icons.borders.thin.right,
                            icons.borders.thin.bottom_right,
                            icons.borders.thin.bottom,
                            icons.borders.thin.bottom_left,
                            icons.borders.thin.left,
                        },
                    },
                },
            })

            return opts
        end,
        config = function(_, opts)
            for _, source in ipairs(opts.sources) do
                source.group_index = source.group_index or 1
            end
            local cmp = require("cmp")
            cmp.setup(opts)
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                }),
            })
        end,
    },
}
