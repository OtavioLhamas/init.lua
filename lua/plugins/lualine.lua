local winbar_filetype_exclude = {
	"help",
	"startify",
	"dashboard",
	"lazy",
	"neo-tree",
	"neogitstatus",
	"NvimTree",
	"Trouble",
	"alpha",
	"lir",
	"Outline",
	"spectre_panel",
	"toggleterm",
	"DressingSelect",
	"Jaq",
	"harpoon",
	"dap-repl",
	"dap-terminal",
	"dapui_console",
	"dapui_hover",
	"lab",
	"notify",
	"noice",
	"neotest-summary",
	"",
}

local get_navic = function()
	if vim.tbl_contains(winbar_filetype_exclude or {}, vim.bo.filetype) then
		return ""
	end

	local navic_ok, navic = pcall(require, "nvim-navic")
	if not navic_ok then
		return ""
	end

	if not navic.is_available() then
		return ""
	end

	local data = navic.get_data()

	if data == nil then
		return ""
	end

	local lib = require("nvim-navic.lib")
	local t = {}
	local ret = ""

	local plugin = require("lazy.core.config").spec.plugins["nvim-navic"]
	local navic_opts = require("lazy.core.plugin").values(plugin, "opts", false)

	for _, v in ipairs(data) do
		if navic_opts.highlight then
			table.insert(
				t,
				"%#NavicIcons"
					.. lib.adapt_lsp_num_to_str(v.kind)
					.. "#"
					.. navic_opts.icons[v.kind]
					.. "%*%#LineNr#"
					.. v.scope.start.line
					.. "%* %#NavicText#"
					.. v.name
					.. "%*"
			)
		else
			table.insert(t, navic_opts.icons[v.kind] .. v.scope.start.line .. " " .. v.name)
		end
	end

	if navic_opts.highlight then
		ret = table.concat(t, "%#NavicSeparator#" .. navic_opts.separator .. "%*")
	else
		ret = table.concat(t, navic_opts.separator)
	end

	return ret
end

local lualine_opts = function()
	local icons = require("util.icons")

	return {
		options = {
			component_separators = { left = "", right = "" },
			disabled_filetypes = { statusline = { "dashboard", "alpha" } },
			globalstatus = true,
			icons_enabled = true,
			section_separators = { left = "", right = "" },
			theme = "auto",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				"branch",
				{
					"diff",
					symbols = {
						added = icons.git.added .. ' ',
						modified = icons.git.modified .. ' ',
						removed = icons.git.removed .. ' ',
					},
				},
			},
			lualine_c = {
				{
					"diagnostics",
					symbols = {
						error = icons.diagnostics.error .. ' ',
						warn = icons.diagnostics.warn .. ' ',
						info = icons.diagnostics.info .. ' ',
						hint = icons.diagnostics.hint .. ' ',
					},
				},
				{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				{ "filename", path = 1, symbols = { modified = " ", readonly = "", unnamed = "" } },
				{ "encoding" },
				{ "fileformat" },
			},
			lualine_x = {
				{
					function()
						return require("noice").api.status.command.get()
					end,
					cond = function()
						return package.loaded["noice"] and require("noice").api.status.command.has()
					end,
				},
				{ require("lazy.status").updates, cond = require("lazy.status").has_updates },
			},
			lualine_y = {
				{ "progress", separator = " ", padding = { left = 1, right = 0 } },
				{ "location", padding = { left = 0, right = 1 } },
			},
			lualine_z = {
				function()
					return icons.clock .. os.date("%R")
				end,
			},
		},
		winbar = {
			lualine_a = {
				{
					function()
						return get_navic()
					end,
					cond = function()
						return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
					end,
					draw_empty = true,
				},
			},
		},
		extensions = { "fugitive", "lazy", "nvim-tree", "toggleterm" },
	}
end

return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = lualine_opts,
	},
}
