local cmp = require("cmp")

local keyword_length = 1

---@type cmp.SourceConfig[]
local sources = {
    buffer = {
        name = "buffer",
        option = {},
        keyword_length = keyword_length,
        priority = 1,
        group_index = vim.NIL,
    },
    emoji = {
        name = "emoji",
        option = {},
        keyword_length = keyword_length,
        priority = 1,
        group_index = vim.NIL,
    },
    lazydev = {
        name = "lazydev",
        option = {},
        keyword_length = keyword_length,
        priority = 10,
        group_index = vim.NIL,
    },
    luasnip = {
        name = "luasnip",
        option = {},
        keyword_length = 0,
        priority = 9,
        group_index = vim.NIL,
    },
    nvim_lsp = {
        name = "nvim_lsp",
        option = {},
        keyword_length = keyword_length,
        entry_filter = function(entry, _)
            return require("cmp.types.lsp").CompletionItemKind[entry:get_kind()] ~= "Text"
        end,
        priority = 9,
        group_index = vim.NIL,
    },
    path = {
        name = "path",
        option = {},
        keyword_length = 2,
        priority = 7,
        group_index = vim.NIL,
    },
    treesitter = {
        name = "treesitter",
        option = {},
        keyword_length = keyword_length,
        priority = 8,
        group_index = vim.NIL,
    },
}

local cmp_mapping = {
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i", "c" }),
    ["<Down>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),

    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i", "c" }),
    ["<Up>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),

    ["<Tab>"] = vim.NIL,
    ["<S-Tab>"] = vim.NIL,

    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),

    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),

    ["<CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    ["<C-y>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<C-CR>"] = function(fallback)
        cmp.abort()
        fallback()
    end,

    ["<C-Space>"] = cmp.mapping.complete(), -- trigger completion without having to type anything
    ["<C-e>"] = cmp.mapping.abort(),
}

local border_icons = {
    empty = {
        top = " ",
        right = " ",
        bottom = " ",
        left = " ",
        top_left = " ",
        top_right = " ",
        bottom_right = " ",
        bottom_left = " ",
    },
    thick = {
        top = "▄",
        right = "█",
        bottom = "▀",
        left = "█",
        top_left = "▄",
        top_right = "▄",
        bottom_right = "▀",
        bottom_left = "▀",
    },
    thin = {
        top = "▔",
        right = "▕",
        bottom = "▁",
        left = "▏",
        top_left = "🭽",
        top_right = "🭾",
        bottom_right = "🭿",
        bottom_left = "🭼",
    },
}

local cmp_opts = {
    completion = {
        keyword_length = keyword_length,
    },

    formatting = {
        -- Field order
        fields = { "abbr", "kind", "menu" },

        format = function(entry, item)
            -- Use the LazyVim icon when available
            if LazyVim.config.icons.kinds[item.kind] then
                item.kind = LazyVim.config.icons.kinds[item.kind] .. " " .. item.kind
            end

            -- prepend each item with the source name, unless its cmdline
            item.menu = (entry.source.name ~= "cmdline") and entry.source.name or ""

            return item
        end,
    },

    mapping = cmp.mapping.preset.insert(cmp_mapping),

    preselect = cmp.PreselectMode.None,

    sorting = {
        comparators = {
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.order,
        },
    },

    window = {
        completion = cmp.config.window.bordered({
            border = {
                border_icons.thin.top_left,
                border_icons.thin.top,
                border_icons.thin.top_right,
                border_icons.thin.right,
                border_icons.thin.bottom_right,
                border_icons.thin.bottom,
                border_icons.thin.bottom_left,
                border_icons.thin.left,
            },
        }),
        documentation = cmp.config.window.bordered({
            border = {
                border_icons.thin.top_left,
                border_icons.thin.top,
                border_icons.thin.top_right,
                border_icons.thin.right,
                border_icons.thin.bottom_right,
                border_icons.thin.bottom,
                border_icons.thin.bottom_left,
                border_icons.thin.left,
            },
        }),
    },
}

local function cmp_config(opts)
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
end

return {
    {
        "nvim-cmp",
        version = false,
        event = "InsertEnter",
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            {
                "hrsh7th/cmp-cmdline",
                keys = { ":", "/", "?" },
            },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-emoji" },
        },
        opts = cmp_opts,
        config = function(_, opts)
            cmp_config(opts)
        end,
    },

    {
        "nvim-cmp",
        opts = function(_, opts)
            local s = vim.deepcopy(sources, true)

            -- merge existing LazyVim sources with declared sources
            for index, value in ipairs(opts.sources) do
                if s[value.name] then
                    LazyVim.merge(opts.sources[index], s[value.name])
                    s[value.name] = nil
                end
            end

            -- add the remaining sources that were not already added by LazyVim
            vim.tbl_extend("force", opts.sources, vim.tbl_values(s))
        end,
    },
}
