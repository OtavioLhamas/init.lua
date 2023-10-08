local Util = require("util")
local thin = require("util.icons").borders.thin

--#region telescope options
local telescope_pickers = {
	find_files = {
		borderchars = {
			prompt = Util.generate_borderchars("empty", nil, {
				top = thin.top,
				top_right = thin.top,
				bottom_left = thin.left,
				left = thin.left,
				top_left = thin.top_left,
			}),
			results = Util.generate_borderchars("empty", nil, {
				bottom_right = thin.bottom,
				bottom = thin.bottom,
				bottom_left = thin.bottom_left,
				left = thin.left,
				top_left = thin.left,
			}),
			preview = Util.generate_borderchars("empty", nil, {
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
			prompt = Util.generate_borderchars("empty", nil, {
				top = thin.top,
				top_right = thin.top,
				bottom_left = thin.left,
				left = thin.left,
				top_left = thin.top_left,
			}),
			results = Util.generate_borderchars("empty", nil, {
				bottom_right = thin.bottom,
				bottom = thin.bottom,
				bottom_left = thin.bottom_left,
				left = thin.left,
				top_left = thin.left,
			}),
			preview = Util.generate_borderchars("empty", nil, {
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
		borderchars = {
			prompt = Util.generate_borderchars("empty", nil, {
				top = thin.top,
				top_right = thin.top,
				bottom_left = thin.left,
				left = thin.left,
				top_left = thin.top_left,
			}),
			results = Util.generate_borderchars("empty", nil, {
				bottom_right = thin.bottom,
				bottom = thin.bottom,
				bottom_left = thin.bottom_left,
				left = thin.left,
				top_left = thin.left,
			}),
			preview = Util.generate_borderchars("empty", nil, {
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
			width = 0.65,
		},
		layout_strategy = "cursor",
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
			prompt = Util.generate_borderchars("empty", nil, {
				top = thin.top,
				top_right = thin.top,
				bottom_left = thin.left,
				left = thin.left,
				top_left = thin.top_left,
			}),
			results = Util.generate_borderchars("empty", nil, {
				bottom_right = thin.bottom,
				bottom = thin.bottom,
				bottom_left = thin.bottom_left,
				left = thin.left,
				top_left = thin.left,
			}),
			preview = Util.generate_borderchars("empty", nil, {
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
			prompt = Util.generate_borderchars("empty", nil, {
				top = thin.top,
				top_right = thin.top,
				bottom_left = thin.left,
				left = thin.left,
				top_left = thin.top_left,
			}),
			results = Util.generate_borderchars("empty", nil, {
				bottom_right = thin.bottom,
				bottom = thin.bottom,
				bottom_left = thin.bottom_left,
				left = thin.left,
				top_left = thin.left,
			}),
			preview = Util.generate_borderchars("empty", nil, {
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
			prompt = Util.generate_borderchars("empty", nil, {
				top = thin.top,
				top_right = thin.top_right,
				right = thin.right,
				bottom_left = thin.left,
				left = thin.left,
				top_left = thin.top_left,
			}),
			results = Util.generate_borderchars("empty", nil, {
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
			prompt = Util.generate_borderchars("empty", nil, {
				top = thin.top,
				top_right = thin.top_right,
				right = thin.right,
				bottom_left = thin.left,
				left = thin.left,
				top_left = thin.top_left,
			}),
			results = Util.generate_borderchars("empty", nil, {
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
			prompt = Util.generate_borderchars("empty", nil, {
				top = thin.top,
				top_right = thin.top_right,
				right = thin.right,
				bottom_left = thin.left,
				left = thin.left,
				top_left = thin.top_left,
			}),
			results = Util.generate_borderchars("empty", nil, {
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
			prompt = Util.generate_borderchars("empty", nil, {
				top = thin.top,
				top_right = thin.top,
				bottom_left = thin.left,
				left = thin.left,
				top_left = thin.top_left,
			}),
			results = Util.generate_borderchars("empty", nil, {
				bottom_right = thin.bottom,
				bottom = thin.bottom,
				bottom_left = thin.bottom_left,
				left = thin.left,
				top_left = thin.left,
			}),
			preview = Util.generate_borderchars("empty", nil, {
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
			prompt = Util.generate_borderchars("empty", nil, {
				top = thin.top,
				top_right = thin.top_right,
				right = thin.right,
				bottom_left = thin.left,
				left = thin.left,
				top_left = thin.top_left,
			}),
			results = Util.generate_borderchars("empty", nil, {
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
			prompt = Util.generate_borderchars("empty", nil, {
				top = thin.top,
				top_right = thin.top_right,
				right = thin.right,
				bottom_left = thin.left,
				left = thin.left,
				top_left = thin.top_left,
			}),
			results = Util.generate_borderchars("empty", nil, {
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
			prompt = Util.generate_borderchars("empty", nil, {
				top = thin.top,
				top_right = thin.top_right,
				right = thin.right,
				bottom_left = thin.left,
				left = thin.left,
				top_left = thin.top_left,
			}),
			results = Util.generate_borderchars("empty", nil, {
				top_right = thin.right,
				right = thin.right,
				bottom_right = thin.bottom_right,
				bottom = thin.bottom,
				bottom_left = thin.bottom_left,
				left = thin.left,
				top_left = thin.left,
			}),
			preview = Util.generate_borderchars("empty", nil, {
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

local function telescope_opts()
	local actions = require("telescope.actions")

	return {
		defaults = {
			border = {},
			color_devicons = true,
			borderchars = {
				prompt = Util.generate_borderchars("empty", nil, {
					top = thin.top,
					top_right = thin.top_right,
					right = thin.right,
					bottom_left = thin.left,
					left = thin.left,
					top_left = thin.top_left,
				}),
				results = Util.generate_borderchars("empty", nil, {
					top_right = thin.right,
					right = thin.right,
					bottom_right = thin.right,
					bottom_left = thin.left,
					left = thin.left,
					top_left = thin.left,
				}),
				preview = Util.generate_borderchars("empty", nil, {
					top_right = thin.right,
					right = thin.right,
					bottom_right = thin.bottom_right,
					bottom = thin.bottom,
					bottom_left = thin.bottom_left,
					left = thin.left,
					top_left = thin.left,
				}),
			},
			initial_mode = "insert",
			layout_strategy = "center",
			mappings = {
				i = {
					["<C-j>"] = actions.cycle_history_next,
					["<C-k>"] = actions.cycle_history_prev,
					["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					["<A-h>"] = function()
						local line = require("telescope.actions.state").get_current_line()
						Util.telescope("find_files", { no_ignore = true, default_text = line })()
					end,
					["<A-i>"] = function()
						local line = require("telescope.actions.state").get_current_line()
						Util.telescope("find_files", { hidden = true, default_text = line })()
					end,
					["<A-p>"] = require("telescope.actions.layout").toggle_preview,
					["<CR>"] = actions.select_default,
				},
				n = {
					["<C-n>"] = actions.move_selection_next,
					["<C-p>"] = actions.move_selection_previous,
					["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					["<A-h>"] = function()
						local line = require("telescope.actions.state").get_current_line()
						Util.telescope("find_files", { no_ignore = true, default_text = line })()
					end,
					["<A-i>"] = function()
						local line = require("telescope.actions.state").get_current_line()
						Util.telescope("find_files", { hidden = true, default_text = line })()
					end,
					["<A-p>"] = require("telescope.actions.layout").toggle_preview,
					["q"] = actions.close,
				},
			},
			path_display = { "smart" },
			--preview_cutoff = 120,
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
		},
		pickers = telescope_pickers,
		extensions = telescope_extensions,
	}
end
--#endregion

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{ "debugloop/telescope-undo.nvim" },
		},
		cmd = "Telescope",
		lazy = true,
		keys = {
			{ "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
			{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Search Buffer" },
			{ "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
			-- find
			{ "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
			{ "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
			{ "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
			-- git
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout Branch" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
			-- search
			{ "<leader>s/", "<cmd>Telescope search_history<cr>", desc = "Search History" },
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>sC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme" },
			{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
			{ "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
			{ "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
			{ "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>ss", Util.telescope("lsp_document_symbols"), desc = "Document Symbols" },
			{ "<leader>sS", Util.telescope("lsp_dynamic_workspace_symbols"), desc = "Workspace Symbols" },
			{ "<leader>st", Util.telescope("treesitter"), desc = "Treesitter" },
			{ "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
			{ "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
			{ "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
			{ "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
			-- telescope-undo
			{ "<leader>U", "<cmd>Telescope undo<cr>", desc = "Undo" },
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup(telescope_opts())

            if not vim.loop.os_uname().sysname == "Windows" then
                telescope.load_extension("fzf")
            end
			telescope.load_extension("undo")
			telescope.load_extension("noice")
			telescope.load_extension("notify")
		end,
	},
}
