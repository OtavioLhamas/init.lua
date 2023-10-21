--- @param type "thin" | "thick" | "empty" | nil
--- @param order "t-r-b-l-tl-tr-br-bl" | "tl-t-tr-r-bl-b-br-l" | nil
--- @param opts BorderIcons | nil
local generate_borderchars = function(type, order, opts)
    if order == nil then
        order = "t-r-b-l-tl-tr-br-bl"
    end
    local border_icons = require("lazyvim.config").icons.borders
    --- @type BorderIcons
    local border = vim.tbl_deep_extend("force", border_icons[type or "empty"], opts or {})

    local borderchars = {}

    local extractDirections = (function()
        local index = 1
        return function()
            if index == nil then
                return nil
            end
            -- Find the next occurence of `char`
            local nextIndex = string.find(order, "-", index)
            -- Extract the first direction
            local direction = string.sub(order, index, nextIndex and nextIndex - 1)
            -- Update the index to nextIndex
            index = nextIndex and nextIndex + 1 or nil
            return direction
        end
    end)()

    local mappings = {
        t = "top",
        r = "right",
        b = "bottom",
        l = "left",
        tl = "top_left",
        tr = "top_right",
        br = "bottom_right",
        bl = "bottom_left",
    }
    local direction = extractDirections()
    while direction do
        if mappings[direction] == nil then
            vim.notify(string.format("Invalid direction '%s'", direction), "error")
        end
        borderchars[#borderchars + 1] = border[mappings[direction]]
        direction = extractDirections()
    end

    if #borderchars ~= 8 then
        vim.notify(string.format("Invalid order '%s'", order), "error")
    end

    return borderchars
end

--#region telescope options
local telescope_pickers = function()
    local thin = require("lazyvim.config").icons.borders.thin
    return {
        find_files = {
            borderchars = {
                prompt = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top,
                    bottom_left = thin.left,
                    left = thin.left,
                    top_left = thin.top_left,
                }),
                results = generate_borderchars("empty", nil, {
                    bottom_right = thin.bottom,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom_left,
                    left = thin.left,
                    top_left = thin.left,
                }),
                preview = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top_right,
                    right = thin.right,
                    bottom_right = thin.bottom_right,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom,
                    top_left = thin.top,
                }),
            },
            follow = true,
            layout_config = {
                height = 0.75,
                mirror = false,
                prompt_position = "top",
                width = 0.80,
            },
            layout_strategy = "horizontal",
            previewer = true,
            preview_title = "",
            results_title = "",
        },
        git_files = {
            borderchars = {
                prompt = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top,
                    bottom_left = thin.left,
                    left = thin.left,
                    top_left = thin.top_left,
                }),
                results = generate_borderchars("empty", nil, {
                    bottom_right = thin.bottom,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom_left,
                    left = thin.left,
                    top_left = thin.left,
                }),
                preview = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top_right,
                    right = thin.right,
                    bottom_right = thin.bottom_right,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom,
                    top_left = thin.top,
                }),
            },
            follow = true,
            layout_config = {
                height = 0.75,
                mirror = false,
                prompt_position = "top",
                width = 0.80,
            },
            layout_strategy = "horizontal",
            previewer = true,
            preview_title = "",
            results_title = "",
        },
        grep_string = {
            layout_config = {
                anchor = "N",
                height = 0.40,
                mirror = true,
                prompt_position = "top",
                width = 0.80,
            },
            preview_title = "",
            results_title = "",
        },
        live_grep = {
            layout_config = {
                anchor = "N",
                height = 0.40,
                mirror = true,
                prompt_position = "top",
                width = 0.80,
            },
            preview_title = "",
            results_title = "",
        },
        buffers = {
            borderchars = {
                prompt = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top,
                    bottom_left = thin.left,
                    left = thin.left,
                    top_left = thin.top_left,
                }),
                results = generate_borderchars("empty", nil, {
                    bottom_right = thin.bottom,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom_left,
                    left = thin.left,
                    top_left = thin.left,
                }),
                preview = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top_right,
                    right = thin.right,
                    bottom_right = thin.bottom_right,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom,
                    top_left = thin.top,
                }),
            },
            layout_config = {
                height = 0.75,
                mirror = false,
                prompt_position = "top",
                width = 0.80,
            },
            layout_strategy = "horizontal",
            preview_title = "",
            results_title = "",
        },
        oldfiles = {
            borderchars = {
                prompt = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top,
                    bottom_left = thin.left,
                    left = thin.left,
                    top_left = thin.top_left,
                }),
                results = generate_borderchars("empty", nil, {
                    bottom_right = thin.bottom,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom_left,
                    left = thin.left,
                    top_left = thin.left,
                }),
                preview = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top_right,
                    right = thin.right,
                    bottom_right = thin.bottom_right,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom,
                    top_left = thin.top,
                }),
            },
            previewer = true,
            layout_config = {
                height = 0.75,
                mirror = false,
                prompt_position = "top",
                width = 0.80,
            },
            layout_strategy = "horizontal",
            preview_title = "",
            results_title = "",
        },
        commands = {
            borderchars = {
                prompt = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top_right,
                    right = thin.right,
                    bottom_left = thin.left,
                    left = thin.left,
                    top_left = thin.top_left,
                }),
                results = generate_borderchars("empty", nil, {
                    top_right = thin.right,
                    right = thin.right,
                    bottom_right = thin.bottom_right,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom_left,
                    left = thin.left,
                    top_left = thin.left,
                }),
            },
            layout_config = {
                height = 0.50,
                mirror = false,
                prompt_position = "top",
                width = 0.65,
            },
        },
        command_history = {
            borderchars = {
                prompt = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top_right,
                    right = thin.right,
                    bottom_left = thin.left,
                    left = thin.left,
                    top_left = thin.top_left,
                }),
                results = generate_borderchars("empty", nil, {
                    top_right = thin.right,
                    right = thin.right,
                    bottom_right = thin.bottom_right,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom_left,
                    left = thin.left,
                    top_left = thin.left,
                }),
            },
        },
        search_history = {
            borderchars = {
                prompt = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top_right,
                    right = thin.right,
                    bottom_left = thin.left,
                    left = thin.left,
                    top_left = thin.top_left,
                }),
                results = generate_borderchars("empty", nil, {
                    top_right = thin.right,
                    right = thin.right,
                    bottom_right = thin.bottom_right,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom_left,
                    left = thin.left,
                    top_left = thin.left,
                }),
            },
        },
        help_tags = {
            layout_config = {
                anchor = "N",
                height = 0.40,
                mirror = true,
                prompt_position = "top",
                width = 0.80,
            },
            preview_title = "",
            results_title = "",
        },
        man_pages = {
            layout_config = {
                anchor = "N",
                height = 0.40,
                mirror = true,
                prompt_position = "top",
                width = 0.80,
            },
            preview_title = "",
            results_title = "",
        },
        colorscheme = {
            borderchars = {
                prompt = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top,
                    bottom_left = thin.left,
                    left = thin.left,
                    top_left = thin.top_left,
                }),
                results = generate_borderchars("empty", nil, {
                    bottom_right = thin.bottom,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom_left,
                    left = thin.left,
                    top_left = thin.left,
                }),
                preview = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top_right,
                    right = thin.right,
                    bottom_right = thin.bottom_right,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom,
                    top_left = thin.top,
                }),
            },
            layout_config = {
                height = 0.35,
                width = 0.35,
            },
            layout_strategy = "cursor",
            previewer = true,
            preview_title = "",
            results_title = "",
        },
        vim_options = {
            borderchars = {
                prompt = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top_right,
                    right = thin.right,
                    bottom_left = thin.left,
                    left = thin.left,
                    top_left = thin.top_left,
                }),
                results = generate_borderchars("empty", nil, {
                    top_right = thin.right,
                    right = thin.right,
                    bottom_right = thin.bottom_right,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom_left,
                    left = thin.left,
                    top_left = thin.left,
                }),
            },
        },
        autocommands = {
            layout_config = {
                anchor = "N",
                height = 0.40,
                mirror = true,
                prompt_position = "top",
                width = 0.80,
            },
            preview_title = "",
            results_title = "",
        },
        keymaps = {
            borderchars = {
                prompt = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top_right,
                    right = thin.right,
                    bottom_left = thin.left,
                    left = thin.left,
                    top_left = thin.top_left,
                }),
                results = generate_borderchars("empty", nil, {
                    top_right = thin.right,
                    right = thin.right,
                    bottom_right = thin.bottom_right,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom_left,
                    left = thin.left,
                    top_left = thin.left,
                }),
            },
        },
        highlights = {
            borderchars = {
                prompt = generate_borderchars("empty", nil, {
                    top = thin.top,
                    top_right = thin.top_right,
                    right = thin.right,
                    bottom_left = thin.left,
                    left = thin.left,
                    top_left = thin.top_left,
                }),
                results = generate_borderchars("empty", nil, {
                    top_right = thin.right,
                    right = thin.right,
                    bottom_right = thin.bottom_right,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom_left,
                    left = thin.left,
                    top_left = thin.left,
                }),
                preview = generate_borderchars("empty", nil, {
                    top_right = thin.right,
                    right = thin.right,
                    bottom_right = thin.bottom_right,
                    bottom = thin.bottom,
                    bottom_left = thin.bottom_left,
                    left = thin.left,
                    top_left = thin.left,
                }),
            },
            layout_config = {
                anchor = "N",
                height = 0.35,
                mirror = true,
                prompt_position = "top",
                width = 0.60,
            },
            previewer = false,
            preview_title = "",
            results_title = "",
        },
        current_buffer_fuzzy_find = {
            layout_config = {
                anchor = "N",
                height = 0.40,
                mirror = true,
                prompt_position = "top",
                width = 0.80,
            },
            preview_title = "",
            results_title = "",
        },
        lsp_document_symbols = {
            layout_config = {
                anchor = "N",
                height = 0.40,
                mirror = true,
                prompt_position = "top",
                width = 0.80,
            },
            preview_title = "",
            results_title = "",
        },
        lsp_dynamic_workspace_symbols = {
            layout_config = {
                anchor = "N",
                height = 0.40,
                mirror = true,
                prompt_position = "top",
                width = 0.80,
            },
            preview_title = "",
            results_title = "",
        },
        git_commits = {
            layout_config = {
                anchor = "N",
                height = 0.35,
                mirror = true,
                prompt_position = "top",
                width = 0.65,
            },
            preview_title = "",
            results_title = "",
        },
        git_branches = {
            layout_config = {
                anchor = "N",
                height = 0.35,
                mirror = true,
                prompt_position = "top",
                width = 0.65,
            },
            preview_title = "",
            results_title = "",
        },
        git_status = {
            layout_config = {
                anchor = "N",
                height = 0.35,
                mirror = true,
                prompt_position = "top",
                width = 0.65,
            },
            preview_title = "",
            results_title = "",
        },
        diagnostics = {
            layout_config = {
                anchor = "N",
                height = 0.35,
                mirror = true,
                prompt_position = "top",
                width = 0.65,
            },
            preview_title = "",
            results_title = "",
        },
        lsp_definitions = {
            layout_config = {
                anchor = "N",
                height = 0.35,
                mirror = true,
                prompt_position = "top",
                width = 0.65,
            },
            preview_title = "",
            results_title = "",
        },
    }
end

local telescope_extensions = {
    fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
    },
    undo = {
        layout_config = {
            anchor = "N",
            height = 0.35,
            mirror = true,
            prompt_position = "top",
            width = 0.65,
        },
        preview_title = "",
        results_title = "",
    },
}

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {
                "debugloop/telescope-undo.nvim",
                keys = {
                    { "<leader>U", "<cmd>Telescope undo<cr>", desc = "Undo" },
                },
            },
        },
        opts = function(_, opts)
            local icons = require("lazyvim.config").icons

            opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
                border = {},
                color_devicons = true,
                borderchars = {
                    prompt = generate_borderchars("empty", nil, {
                        top = icons.borders.thin.top,
                        top_right = icons.borders.thin.top_right,
                        right = icons.borders.thin.right,
                        bottom_left = icons.borders.thin.left,
                        left = icons.borders.thin.left,
                        top_left = icons.borders.thin.top_left,
                    }),
                    results = generate_borderchars("empty", nil, {
                        top_right = icons.borders.thin.right,
                        right = icons.borders.thin.right,
                        bottom_right = icons.borders.thin.right,
                        bottom_left = icons.borders.thin.left,
                        left = icons.borders.thin.left,
                        top_left = icons.borders.thin.left,
                    }),
                    preview = generate_borderchars("empty", nil, {
                        top_right = icons.borders.thin.right,
                        right = icons.borders.thin.right,
                        bottom_right = icons.borders.thin.bottom_right,
                        bottom = icons.borders.thin.bottom,
                        bottom_left = icons.borders.thin.bottom_left,
                        left = icons.borders.thin.left,
                        top_left = icons.borders.thin.left,
                    }),
                },
                initial_mode = "insert",
                layout_strategy = "center",
                path_display = { "smart" },
                preview_title = "",
                results_title = "",
                selection_strategy = "reset",
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
                winblend = 10,
            })

            local actions = require("telescope.actions")
            opts.defaults.mappings = vim.tbl_deep_extend("force", opts.defaults.mappings, {
                i = {
                    ["<C-j>"] = actions.cycle_history_next,
                    ["<C-k>"] = actions.cycle_history_prev,
                    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    ["<A-p>"] = require("telescope.actions.layout").toggle_preview,
                    ["<CR>"] = actions.select_default,
                },
                n = {
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    ["<A-p>"] = require("telescope.actions.layout").toggle_preview,
                },
            })

            opts.pickers = telescope_pickers()
            opts.extensions = telescope_extensions

            return opts
        end,
    },
}
