local which_key = require('which-key')

which_key.setup({
    plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    },
    window = {
        border = 'single', -- none, single, double, shadow
    },
})

-- VISUAL leader mappings
which_key.register(
    {
        ['/'] = { '<Plug>(comment_toggle_linewise_visual)', 'Comment toggle' }
    },
    {
        mode = 'v', -- VISUAL mode
        prefix = '<leader>',
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }
)

-- NORMAL leader mappings
which_key.register(
    {
        ['/'] = { '<Plug>(comment_toggle_linewise_current)', 'Comment toggle' },
        [';'] = { '<cmd>Ex<cr>', 'Explore' },
        ['c'] = { '<cmd>BufferKill<CR>', 'Close Buffer' },
        ['h'] = { '<cmd>nohlsearch<CR>', 'No Highlight' },
        ['w'] = { '<cmd>w!<CR>', 'Save' },
        ['f'] = { '<cmd>Format<cr>', 'Format' },
        b = {
            name = 'Buffers',
            D = {
                '<cmd>BufferLineSortByDirectory<cr>',
                'Sort by directory',
            },
            e = {
                '<cmd>BufferLinePickClose<cr>',
                'Pick which buffer to close',
            },
            f = { '<cmd>Telescope buffers<cr>', 'Find' },
            h = { '<cmd>BufferLineCloseLeft<cr>', 'Close all to the left' },
            j = { '<cmd>BufferLinePick<cr>', 'Jump' },
            L = {
                '<cmd>BufferLineSortByExtension<cr>',
                'Sort by language',
            },
            l = {
                '<cmd>BufferLineCloseRight<cr>',
                'Close all to the right',
            },
            n = { '<cmd>BufferLineCycleNext<cr>', 'Next' },
            p = { '<cmd>BufferLineCyclePrev<cr>', 'Previous' },
        },
        g = {
            name = 'Git',
            b = { '<cmd>lua require "gitsigns".blame_line()<cr>', 'Blame float' },
            B = { '<cmd>Git blame<cr>', 'Blame' },
            d = { '<cmd>Gdiffsplit<cr>', 'Diff' },
            g = { '<cmd>G<cr>', 'Fugitive' },
            l = { '<cmd>Gitsigns toggle_current_line_blame<cr>', 'Toggle inline blame' },
        },
        l = {
            name = 'LSP',
            a = { vim.lsp.buf.code_action(), 'Code Action' },
            d = { '<cmd>Telescope diagnostics bufnr=0<cr>', 'Buffer diagnostics' },
            D = { '<cmd>Telescope diagnostics<cr>', 'Diagnostics' },
            f = { vim.lsp.buf.format, 'Format' },
            j = {
                vim.diagnostic.goto_next,
                'Next Diagnostic',
            },
            k = {
                vim.diagnostic.goto_prev,
                'Prev Diagnostic',
            },
            l = { vim.lsp.codelens.run, "CodeLens Action" },
            r = { vim.lsp.buf.rename, 'Rename' },
        },
        p = {
            name = 'Packer',
            c = { '<cmd>PackerCompile<cr>', 'Compile' },
            i = { '<cmd>PackerInstall<cr>', 'Install' },
            s = { '<cmd>PackerSync<cr>', 'Sync' },
            S = { '<cmd>PackerStatus<cr>', 'Status' },
            u = { '<cmd>PackerUpdate<cr>', 'Update' },
        },
        t = {
            name = 'Telescope',
            ['/'] = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Fuzzy search open buffer' },
            ['<space>'] = { '<cmd>Telescope buffers<cr>', 'Open buffers' },
            b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
            C = { '<cmd>Telescope commands<cr>', 'Commands' },
            d = { '<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>', 'Buffer diagnostics' },
            D = { '<cmd>Telescope diagnostics<cr>', 'Diagnostics' },
            f = { '<cmd>Telescope find_files<cr>', 'Files' },
            g = { '<cmd>Telescope live_grep<cr>', 'Grep' },
            G = { '<cmd>Telescope git_status<cr>', 'Git status' },
            h = { '<cmd>Telescope help_tags<cr>', 'Help' },
            H = { '<cmd>Telescope highlights<cr>', 'Highlight groups' },
            k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
            p = { '<cmd>Telescope git_files<cr>', 'Git project' },
            r = { '<cmd>Telescope oldfiles<cr>', 'Recent Files' },
            s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document symbols' },
            S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workspace symbols' },
            t = { '<cmd>Telescope treesitter<cr>', 'Treesitter' },
            w = { '<cmd>Telescope grep_string<cr>', 'Current word' },
        },
    },
    {
        mode = 'n', -- NORMAL mode
        prefix = '<leader>',
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    })

-- NORMAL mappings
which_key.register(
    {
        [']'] = {
            name = 'Next',
            d = {
                vim.diagnostic.goto_next,
                'Diagnostic',
            },
        },
        ['['] = {
            name = 'Previous',
            d = {
                vim.diagnostic.goto_prev,
                'Diagnostic',
            },
        },
        g = {
            name = 'LSP',
            d = { '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>', 'Definitions' },
            D = { '<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>', 'Type definitions' },
            I = { '<cmd>lua require("telescope.builtin").lsp_implementations()<cr>', 'Type definitions' },
            l = {
                function()
                    local config = {
                        scope = 'line',
                        virtual_text = true,
                        update_in_insert = false,
                        underline = true,
                        severity_sort = true,
                        float = {
                            focusable = false,
                            style = 'minimal',
                            border = 'rounded',
                            source = 'always',
                            header = '',
                            prefix = '',
                            format = function(d)
                                local code = d.code or (d.user_data and d.user_data.lsp.code)
                                if code then
                                    return string.format('%s [%s]', d.message, code):gsub('1. ', '')
                                end
                                return d.message
                            end,
                        },
                    }
                    vim.diagnostic.open_float(config)
                end,
                'Line diagnostic'
            },
            r = { '<cmd>lua require("telescope.builtin").lsp_references()<cr>', 'References' },
            s = { vim.lsp.buf.signature_help, 'Signature help' },
        },
    },
    {
        mode = 'n',
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
    }
)
