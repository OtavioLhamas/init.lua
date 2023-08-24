return {
	clock = " ",
    indent = "│",
	diagnostics = {
		error = "",
		warn = "",
		hint = "",
		info = "",
	},
	git = {
		added = "",
		modified = "",
		removed = "",
		renamed = "➜",
		untracked = "",
		ignored = "",
		unstaged = "U",
		staged = "",
		conflict = "",
		deleted = "",
	},
	gitsigns = {
		add = "┃",
		change = "┋",
		delete = "",
		topdelhfe = "",
		changedelete = "┃",
		untracked = "┃",
	},
	kinds = {
		Array = "",
		Boolean = "",
		Class = "",
		Color = "",
		Constant = "",
		Constructor = "",
		Copilot = "",
		Enum = "",
		EnumMember = "",
		Event = "",
		Field = "",
		File = "",
		Folder = "",
		Function = "",
		Interface = "",
		Key = "",
		Keyword = "",
		Method = "",
		Module = "",
		Namespace = "",
		Null = "",
		Number = "",
		Object = "",
		Operator = "",
		Package = "",
		Property = "",
		Reference = "",
		Snippet = "",
		String = "",
		Struct = "",
		Text = "",
		TypeParameter = "",
		Unit = "",
		Value = "",
		Variable = "",
		Macro = "", -- Macro
	},
	navic = {
		[1] = " ", -- File
		[2] = " ", -- Module
		[3] = " ", -- Namespace
		[4] = " ", -- Package
		[5] = " ", -- Class
		[6] = " ", -- Method
		[7] = " ", -- Property
		[8] = " ", -- Field
		[9] = " ", -- Constructor
		[10] = "練", -- Enum
		[11] = "練", -- Interface
		[12] = " ", -- Function
		[13] = " ", -- Variable
		[14] = " ", -- Constant
		[15] = " ", -- String
		[16] = " ", -- Number
		[17] = "◩ ", -- Boolean
		[18] = " ", -- Array
		[19] = " ", -- Object
		[20] = " ", -- Key
		[21] = "ﳠ ", -- Null
		[22] = " ", -- EnumMember
		[23] = " ", -- Struct
		[24] = " ", -- Event
		[25] = " ", -- Operator
		[26] = " ", -- TypeParameter
		[255] = " ", -- Macro
	},
	borders = {
		--- @class BorderIcons
		thin = {
			top = "▔",
			right = "▕",
			bottom = "▁",
			left = "▏",
			top_left = "🭽",
			top_right = "🭾",
			bottom_right = "🭿",
			bottom_left = "🭼",
		},
		---@type BorderIcons
		empty = {
			top = " ",
			right = " ",
			bottom = " ",
			left = " ",
			top_left = " ",
			top_right = " ",
			bottom_right = " ",
			bottom_left = " ",
		},
		---@type BorderIcons
		thick = {
			top = "▄",
			right = "█",
			bottom = "▀",
			left = "█",
			top_left = "▄",
			top_right = "▄",
			bottom_right = "▀",
			bottom_left = "▀",
		},
	},
}
