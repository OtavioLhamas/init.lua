require('neodev').setup()

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'lua_ls',
    'rust_analyzer',
    'omnisharp',
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_mapping = require('cmp.config.mapping')

lsp.setup_nvim_cmp({
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Insert,
    },
    completion = {
        keyword_length = 1,
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        duplicates = {
            buffer = 1,
            path = 1,
            nvim_lsp = 0,
            luasnip = 1,
        },
        duplicates_default = 0,
    },
    mapping = lsp.defaults.cmp_mappings({
        ['<C-k>'] = cmp_mapping(cmp_mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i', 'c' }),
        ['<C-j>'] = cmp_mapping(cmp_mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i', 'c' }),
        ['<C-p>'] = cmp_mapping(cmp_mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i', 'c' }),
        ['<C-n>'] = cmp_mapping(cmp_mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i', 'c' }),
        ['<Down>'] = cmp_mapping(cmp_mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
        ['<Up>'] = cmp_mapping(cmp_mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
        ['<C-u>'] = cmp_mapping.scroll_docs( -4),
        ['<C-d>'] = cmp_mapping.scroll_docs(4),
        ['<C-y>'] = cmp_mapping({
            i = cmp_mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = false },
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = false }
                else
                    fallback()
                end
            end,
        }),
        ['<Tab>'] = vim.NIL,
        ['<S-Tab>'] = vim.NIL,
        ['<C-Space>'] = cmp_mapping.complete(),
        ['<C-e>'] = cmp_mapping.abort(),
        ["<CR>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
                local confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false } -- avoid mutating the original opts below
                local is_insert_mode = function()
                    return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
                end
                if is_insert_mode() then -- prevent overwriting brackets
                    confirm_opts.behavior = cmp.ConfirmBehavior.Insert
                end
                if cmp.confirm(confirm_opts) then
                    return -- success, exit early
                end
            end
            fallback() -- if not exited early, always fallback
        end),
    }),
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
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
        { name = "emoji" },
        { name = "treesitter" },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' },
    },
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    })
})
-- omnisharp lsp config
-- lsp.configure('omnisharp', {
--   capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
--   on_attach = function (_, bufnr)
--     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--   end,
--   cmd = { os.getenv('UserProfile') .. '\\omnisharp-win-x64\\OmniSharp.exe', "--languageserver" , "--hostPID", tostring(pid) },
-- })

-- lsp.use('omnisharp', {
--   settings = {
--     omnisharp = {
--       enableImportCompletion = true,
--     }
--   }
-- })

lsp.on_attach(function(client, bufnr)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    -- navic context line
    if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
    end

end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

require('fidget').setup()

