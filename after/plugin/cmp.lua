local lsp = require('lsp-zero')
local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_window = require('cmp.config.window')
local cmp_mapping = require('cmp.config.mapping')


local cmp_opts = {
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Insert,
    },
    completion = {
        keyword_length = 1,
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        source_names = {
            nvim_lsp = "(LSP)",
            emoji = "(Emoji)",
            path = "(Path)",
            calc = "(Calc)",
            cmp_tabnine = "(Tabnine)",
            vsnip = "(Snippet)",
            luasnip = "(Snippet)",
            buffer = "(Buffer)",
            tmux = "(TMUX)",
            copilot = "(Copilot)",
            treesitter = "(TreeSitter)",
        },
    },
    duplicates = {
        buffer = 1,
        path = 1,
        nvim_lsp = 0,
        luasnip = 1,
    },
    duplicates_default = 0,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp_window.bordered(),
        documentation = cmp_window.bordered(),
    },
    sources = {
        {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
                local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                    return false
                end
                if kind == "Text" then
                    return false
                end
                return true
            end,
        },

        { name = "path" },
        { name = "luasnip" },
        { name = "cmp_tabnine" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "treesitter" },
    }
}

