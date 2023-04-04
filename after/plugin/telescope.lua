-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local telescope = require('telescope')
local actions = require('telescope.actions')

local pickers = {
    find_files = {
        theme = "dropdown",
        hidden = true,
        previewer = false,
    },
    live_grep = {
        --@usage don't include the filename in the search results
        only_sort_text = true,
        layout_strategy = 'horizontal',
        layout_config = {
            height = function(_, _, max_lines)
                local percentage = 0.75
                local min = 30
                return math.max(math.floor(percentage * max_lines), min)
            end,
            preview_cutoff = 1,
            prompt_position = 'top',
            width = function(_, max_columns, _)
                local percentage = 0.75
                local max = 140
                return math.max(math.floor(percentage * max_columns), max)
            end,
        },
    },
    grep_string = {
        only_sort_text = true,
        theme = "dropdown",
    },
    buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        mappings = {
            i = {
                ["<C-d>"] = actions.delete_buffer,
            },
            n = {
                ["dd"] = actions.delete_buffer,
            },
        },
    },
    planets = {
        show_pluto = true,
        show_moon = true,
    },
    git_files = {
        theme = "dropdown",
        hidden = true,
        previewer = false,
        show_untracked = true,
    },
    lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
    },
    lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
    },
    lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
    },
    lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
    },
}

local opts = {
    theme = 'dropdown',
    defaults = {
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        dynamic_preview_title = true,
        file_ignore_patterns = {},
        initial_mode = 'insert',
        layout_config = {
            width = 0.75,
            preview_cutoff = 120,
            horizontal = {
                preview_width = function(_, cols, _)
                    if cols < 120 then
                        return math.floor(cols * 0.5)
                    end
                    return math.floor(cols * 0.6)
                end,
                mirror = false,
            },
            vertical = { mirror = false },
        },
        layout_strategy = 'horizontal',
        mappings = {
            i = {
                ['<C-j>'] = actions.cycle_history_next,
                ['<C-k>'] = actions.cycle_history_prev,
                ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
                ['<CR>'] = actions.select_default,
            },
            n = {
                ['<C-n>'] = actions.move_selection_next,
                ['<C-p>'] = actions.move_selection_previous,
                ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
                ['<C-c>'] = actions.close,
            }
        },
        path_display = { 'smart' },
        pickers = pickers,
        selection_strategy = 'reset',
        set_env = { ['COLORTERM'] = 'truecolor' },
        sorting_strategy = 'descending',
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob=!.git/',
        },
        winblend = 10,
    },
    pickers = pickers,
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
        },
    },
}

local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')

opts = vim.tbl_extend('keep', {
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        file_sorter = sorters.get_fuzzy_file,
        generic_sorter = sorters.get_generic_fuzzy_sorter,
    }, opts)

telescope.setup(opts)

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')

pcall(telescope.load_extension, 'harpoon')
pcall(telescope.load_extension, 'projects')

