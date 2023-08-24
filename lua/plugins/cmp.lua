local icons = require("util.icons")
local thin = icons.borders.thin

local source_names = {
    nvim_lsp = "(LSP)",
    emoji = "(Emoji)",
    path = "(Path)",
    calc = "(Calc)",
    cmp_tabnine = "(Tabnine)",
    vsnip = "(Snippet)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
    treesitter = "(TreeSitter)",
}

local cmp_sources = {
    { name = "buffer", priority = 6 },
    { name = "cmp_tabnine" },
    { name = "emoji" },
    { name = "luasnip", priority = 8 },
    { name = "nvim_lua", priority = 8 },
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

local function cmp_mapping(cmp)
    return {
        ["<C-p>"] = cmp.mapping(
            cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            { "i", "c" }
        ),
        ["<C-n>"] = cmp.mapping(
            cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            { "i", "c" }
        ),
        ["<Down>"] = cmp.mapping(
            cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            { "i" }
        ),
        ["<Up>"] = cmp.mapping(
            cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            { "i" }
        ),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-y>"] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
        }),
        ["<Tab>"] = vim.NIL,
        ["<S-Tab>"] = vim.NIL,
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                local confirm_opts = { behavior = cmp.ConfirmBehavior.Insert, select = false }
                local is_insert_mode = function()
                    return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
                end
                if is_insert_mode() then
                    confirm_opts.behavior = cmp.ConfirmBehavior.Insert
                end
                local entry = cmp.get_selected_entry()
                local is_copilot = entry and entry.source.name == "copilot"
                if is_copilot then
                    confirm_opts.behavior = cmp.ConfirmBehavior.Replace
                    confirm_opts.select = true
                end
                if cmp.confirm(confirm_opts) then
                    return -- success, exit early
                end
            end
            fallback() -- if not exited early, always fallback
        end),
    }
end

local function cmp_opts()
    local cmp = require("cmp")
    local cmp_window = require("cmp.config.window")
    local cmp_compare = require("cmp.config.compare")

    return {
        completion = {
            keyword_lenght = 1,
        },
        enabled = function()
            local buftype = vim.api.nvim_buf_get_option(0, "buftype")
            if buftype == "prompt" then
                return false
            end
            return true
        end,
        formatting = {
            fields = { "menu", "abbr", "kind" },
            format = function(entry, item)
                if icons.kinds[item.kind] then
                    item.kind = icons.kinds[item.kind] .. " " .. item.kind
                end
                item.menu = source_names[entry.source.name]
                return item
            end,
        },
        mapping = cmp.mapping.preset.insert(cmp_mapping(cmp)),
        preselect = cmp.PreselectMode.None,
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        sorting = {
            comparators = {
                cmp_compare.score,
                cmp_compare.order,
                cmp_compare.locality,
                cmp_compare.recently_used,
            },
        },
        sources = cmp.config.sources(cmp_sources),
        window = {
            completion = cmp_window.bordered({
                border = {
                    thin.top_left,
                    thin.top,
                    thin.top_right,
                    thin.right,
                    thin.bottom_right,
                    thin.bottom,
                    thin.bottom_left,
                    thin.left,
                },
            }),
            documentation = cmp_window.bordered({
                border = {
                    thin.top_left,
                    thin.top,
                    thin.top_right,
                    thin.right,
                    thin.bottom_right,
                    thin.bottom,
                    thin.bottom_left,
                    thin.left,
                },
            }),
        },
    }
end

local function setup_cmp(opts)
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
end

return {
	-- snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			-- TODO look into LuaSnip options
			history = true,
			delete_check_events = "TextChanged",
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
			},
		},
	},

	-- auto completion
	{
		"hrsh7th/nvim-cmp",
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
		config = function(_, opts) setup_cmp(opts) end,
	},
}
