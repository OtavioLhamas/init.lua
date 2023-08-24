local icons = require("util.icons")
local thin = icons.borders.thin

local noice_opts = {
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	routes = {
		{
			-- mini message for workspace loading notifications
			filter = {
				event = "msg_show",
				any = {
					{ find = "%d+L, %d+B" },
					{ find = "; after #%d+" },
					{ find = "; before #%d+" },
				},
			},
			-- fidget.nvim style
			view = "mini",
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = true,
	},
	views = {
		-- TODO investigate how to customize notify popup colors
		cmdline_popup = {
			border = {
				style = {
					thin.top_left,
					thin.top,
					thin.top_right,
					thin.right,
					thin.bottom_right,
					thin.bottom,
					thin.bottom_left,
					thin.left,
				},
				padding = { 1, 2 },
			},
		},
		hover = {
			border = {
				style = {
					thin.top_left,
					thin.top,
					thin.top_right,
					thin.right,
					thin.bottom_right,
					thin.bottom,
					thin.bottom_left,
					thin.left,
				},
			},
		},
		popup = {
			border = {
				style = {
					thin.top_left,
					thin.top,
					thin.top_right,
					thin.right,
					thin.bottom_right,
					thin.bottom,
					thin.bottom_left,
					thin.left,
				},
			},
		},
	},
	commands = {
		history = {
			view = "split",
			filter_opts = { reverse = true },
			opts = { enter = true },
		},
	},
}

local notify_opts = {
	icons = {
		DEBUG = "",
		ERROR = icons.diagnostics.error,
		INFO = icons.diagnostics.info,
		TRACE = icons.diagnostics.hint,
		WARN = icons.diagnostics.warn,
	},
}

return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			{
				"MunifTanjim/nui.nvim",
			},
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			{
				"rcarriga/nvim-notify",
				opts = notify_opts,
			},
		},
		opts = noice_opts,
		keys = {
			{
				"<S-Enter>",
				function()
					require("noice").redirect(vim.fn.getcmdline())
				end,
				mode = "c",
				desc = "Redirect Cmdline",
			},
			{
				"<leader>snl",
				function()
					require("noice").cmd("last")
				end,
				desc = "Noice Last Message",
			},
			{
				"<leader>snh",
				function()
					require("noice").cmd("history")
				end,
				desc = "Noice History",
			},
			{
				"<leader>sna",
				function()
					require("noice").cmd("all")
				end,
				desc = "Noice All",
			},
			{
				"<leader>snd",
				function()
					require("noice").cmd("dismiss")
				end,
				desc = "Dismiss All",
			},
			{
				"<c-f>",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<c-f>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll forward",
				mode = { "i", "n", "s" },
			},
			{
				"<c-b>",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<c-b>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll backward",
				mode = { "i", "n", "s" },
			},
		},
	},
}
