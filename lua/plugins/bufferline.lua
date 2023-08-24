local function close(bufnr, force)
	require("mini.bufremove").delete(bufnr, force)
end

local bufferlineOpts = {
	options = {
		always_show_bufferline = false,
		close_command = function(n)
			close(n, false)
		end,
		color_icons = true,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(_, _, diag)
			local icons = require("util.icons").diagnostics
			local ret = (diag.error and icons.error .. diag.error .. " " or "")
				.. (diag.warning and icons.warn .. diag.warning or "")
			return vim.trim(ret)
		end,
		enforce_regular_tabs = false,
		get_element_icon = function(buf)
			return require("nvim-web-devicons").get_icon()
		end,
		mode = "buffers",
		numbers = "both",
		offsets = {
			{
				filetype = "DiffviewFiles",
				text = "Diff View",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "NvimTree",
				highlight = "PanelHeading",
				text = "File Explorer",
				text_align = "center",
			},
		},
		persist_buffer_sort = true,
		right_mouse_command = function(n)
			close(n, false)
		end,
		separator_style = "thin",
		show_buffer_close_icons = true,
		show_buffer_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		sort_by = "id",
		themable = true,
	},
}

return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Left" },
			{ "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Pick" },
			{ "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close Right" },
			{ "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin" },
			{ "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned" },
			{ "<leader>bs", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort By Extension" },
			{ "<leader>bS", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort By Directory" },
		},
		opts = bufferlineOpts,
	},
}
