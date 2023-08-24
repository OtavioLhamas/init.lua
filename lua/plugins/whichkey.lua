local Util = require("util")
local thin = require("util.icons").borders.thin

local key_opts = {
	defaults = {
		mode = { "n", "v" },
		["g"] = { name = "+goto", s = { "+surround" } },
		["]"] = { name = "+next" },
		["["] = { name = "+prev" },
		["<leader>b"] = { name = "+buffer" },
		["<leader>c"] = { name = "+code" },
		["<leader>f"] = { name = "+file/find" },
		["<leader>g"] = { name = "+git", h = { "+gitsigns" } },
		["<leader>l"] = { name = "+lsp" },
		["<leader>s"] = { name = "+search" },
		["<leader>u"] = { name = "+options" },
	},
	plugins = {
		marks = false, -- shows a list of your marks on ' and `
		registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
	},
	window = {
		border = {
			thin.top_left,
			thin.top,
			thin.top_right,
			thin.right,
			thin.bottom_right,
			thin.bottom,
			thin.bottom_left,
			thin.left,
		}, -- none, single, double, shadow
	},
}

if Util.has("noice.nvim") then
	key_opts.defaults["<leader>sn"] = { name = "+noice" }
end

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = key_opts,
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
}
