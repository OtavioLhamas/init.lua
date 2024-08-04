local icons = require("util").icons
local border_thin = icons.border.thin

--#region Default borderchars
local center_borderchars = {
    preview = {
        border_thin.top,
        border_thin.right,
        border_thin.bottom,
        border_thin.left,
        border_thin.top_left,
        border_thin.top_right,
        border_thin.bottom_right,
        border_thin.bottom_left,
    },
    prompt = {
        border_thin.top,
        border_thin.right,
        " ",
        border_thin.left,
        border_thin.top_left,
        border_thin.top_right,
        " ",
        " ",
    },
    results = {
        " ",
        border_thin.right,
        border_thin.bottom,
        border_thin.left,
        border_thin.left,
        border_thin.right,
        border_thin.bottom_right,
        border_thin.bottom_left,
    },
}

local horizontal_borderchars = {
    preview = {
        border_thin.top,
        border_thin.right,
        border_thin.bottom,
        border_thin.left,
        border_thin.top_left,
        border_thin.top_right,
        border_thin.bottom_right,
        border_thin.bottom_left,
    },
    prompt = {
        border_thin.top,
        border_thin.right,
        " ",
        border_thin.left,
        border_thin.top_left,
        border_thin.top_right,
        border_thin.right,
        border_thin.left,
    },
    results = {
        " ",
        border_thin.right,
        border_thin.bottom,
        border_thin.left,
        border_thin.left,
        border_thin.right,
        border_thin.bottom_right,
        border_thin.bottom_left,
    },
}
--#endregion

return {
    "telescope.nvim",
    keys = {
        {
            "<leader>,",
            "<cmd>Telescope buffers sort_mru=true sort_lastused=true show_all_buffers=true<cr>",
            desc = "Switch Buffer",
        },
        { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },

        -- git
        { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout Branch" },
        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },

        -- search
        { "<leader>s/", "<cmd>Telescope search_history<cr>", desc = "Search History" },
    },
    opts = function(_, opts)
        local actions = require("telescope.actions")

        --#region defaults
        opts.defaults = LazyVim.merge(opts.defaults, {
            border = {},
            borderchars = center_borderchars,
            color_devicons = true,
            -- TODO: test if I need to configure git_worktrees option
            initial_mode = "insert",
            layout_config = {
                center = {
                    anchor = "N",
                    height = 0.40,
                    mirror = true,
                    preview_cutoff = 40,
                    prompt_position = "top",
                    width = 0.60,
                },
                horizontal = {
                    height = 0.75,
                    mirror = false,
                    prompt_position = "top",
                    width = 0.80,
                },
                cursor = {
                    height = 0.45,
                    width = 0.75,
                    preview_cutoff = 190,
                },
            },
            layout_strategy = "center",
            mappings = {
                i = {
                    ["<C-j>"] = actions.cycle_history_next,
                    ["<C-k>"] = actions.cycle_history_prev,
                    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    ["<A-p>"] = require("telescope.actions.layout").toggle_preview,
                },
                n = {
                    ["<C-j>"] = actions.cycle_history_next,
                    ["<C-k>"] = actions.cycle_history_prev,
                    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    ["<A-p>"] = require("telescope.actions.layout").toggle_preview,
                    ["<C-Down>"] = actions.cycle_history_next,
                    ["<C-Up>"] = actions.cycle_history_prev,
                    ["<C-f>"] = actions.preview_scrolling_down,
                    ["<C-b>"] = actions.preview_scrolling_up,
                },
            },
            path_display = {
                -- diplay only the file name first
                "filename_first",
                -- followed by the shortened path,
                shorten = {
                    len = 3, -- showing only the first 3 characters of each directory
                    exclude = { 1, -1, -2 }, -- don't shorten the first and last directories, and the file name itself
                },
            },
            preview_title = "",
            results_title = "",
            set_env = { ["COLORTERM"] = "truecolor" },
            sorting_strategy = "ascending",
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--glob=!**/.git/*",
            },
            winblend = 2,
            wrap_results = false,
        })
        --#endregion

        --#region pickers
        opts.pickers = LazyVim.merge(opts.pickers, {
            autocommands = {
                preview_title = "",
            },
            buffers = {
                borderchars = horizontal_borderchars,
                layout_strategy = "horizontal",
                previewer = true,
                preview_title = "",
                results_title = "",
            },
            current_buffer_fuzzy_find = {
                preview_title = "",
            },
            diagnostics = {
                preview_title = "",
            },
            find_files = {
                borderchars = horizontal_borderchars,
                follow = true,
                layout_strategy = "horizontal",
                previewer = true,
                preview_title = "",
                results_title = "",
            },
            git_branches = {
                preview_title = "",
            },
            git_commits = {
                borderchars = horizontal_borderchars,
                follow = true,
                layout_strategy = "horizontal",
                previewer = true,
                preview_title = "",
                results_title = "",
            },
            git_files = {
                borderchars = horizontal_borderchars,
                follow = true,
                layout_strategy = "horizontal",
                previewer = true,
                preview_title = "",
                results_title = "",
            },
            git_status = {
                borderchars = horizontal_borderchars,
                follow = true,
                layout_strategy = "horizontal",
                previewer = true,
                preview_title = "",
                results_title = "",
            },
            grep_string = {
                borderchars = horizontal_borderchars,
                layout_strategy = "cursor",
                previewer = true,
                preview_title = "",
                results_title = "",
            },
            help_tags = {
                preview_title = "",
            },
            highlights = {
                preview_title = "",
            },
            live_grep = {
                borderchars = horizontal_borderchars,
                layout_strategy = "horizontal",
                previewer = true,
                preview_title = "",
                results_title = "",
            },
            lsp_document_symbols = {
                preview_title = "",
            },
            lsp_definitions = {
                borderchars = horizontal_borderchars,
                layout_strategy = "cursor",
                previewer = true,
                preview_title = "",
                results_title = "",
            },
            lsp_dynamic_workspace_symbols = {
                preview_title = "",
            },
            lsp_implementations = {
                borderchars = horizontal_borderchars,
                layout_strategy = "cursor",
                previewer = true,
                preview_title = "",
                results_title = "",
            },
            lsp_references = {
                borderchars = horizontal_borderchars,
                layout_strategy = "cursor",
                previewer = true,
                preview_title = "",
                results_title = "",
            },
            lsp_type_definitions = {
                borderchars = horizontal_borderchars,
                layout_strategy = "cursor",
                previewer = true,
                preview_title = "",
                results_title = "",
            },
            man_pages = {
                preview_title = "",
            },
            oldfiles = {
                borderchars = horizontal_borderchars,
                follow = true,
                layout_strategy = "horizontal",
                previewer = true,
                preview_title = "",
                results_title = "",
            },
        })
        --#endregion

        return opts
    end,
}
