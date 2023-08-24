local load_textobjects = false

--#region treesitter
local ts_opts = {
	-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"c_sharp",
		"go",
		"html",
		"javascript",
		"jsdoc",
		"json",
		"lua",
		"luadoc",
		"luap",
		"markdown",
		"markdown_inline",
		"python",
		"query",
		"regex",
		"rust",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"yaml",
	},
	highlight = { enable = true },
	-- use treesitter for autoindent with `=`
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
}
--#endregion

--#region mini.ai
local function miniai_opts()
	local ai = require("mini.ai")
	return {
		n_lines = 500,
		custom_textobjects = {
			o = ai.gen_spec.treesitter({
				a = { "@block.outer", "@conditional.outer", "@loop.outer" },
				i = { "@block.inner", "@conditional.inner", "@loop.inner" },
			}, {}),
			f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
			c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
		},
	}
end

local function disable_textobjects(opts)
	if opts.textobjects then
		for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
			if opts.textobjects[mod] and opts.textobjects[mod].enable then
				local Loader = require("lazy.core.loader")
				Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
				local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
				require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
				break
			end
		end
	end
end

local function register_textobjects_keys()
	require("util").on_load("which-key.nvim", function()
		---@type table<string, string|table>
		local i = {
			[" "] = "Whitespace",
			['"'] = 'Balanced "',
			["'"] = "Balanced '",
			["`"] = "Balanced `",
			["("] = "Balanced (",
			[")"] = "Balanced ) including white-space",
			[">"] = "Balanced > including white-space",
			["<lt>"] = "Balanced <",
			["]"] = "Balanced ] including white-space",
			["["] = "Balanced [",
			["}"] = "Balanced } including white-space",
			["{"] = "Balanced {",
			["?"] = "User Prompt",
			_ = "Underscore",
			a = "Argument",
			b = "Balanced ), ], }",
			c = "Class",
			f = "Function",
			o = "Block, conditional, loop",
			q = "Quote `, \", '",
			t = "Tag",
		}
		local a = vim.deepcopy(i)
		for k, v in pairs(a) do
			a[k] = v:gsub(" including.*", "")
		end

		local ic = vim.deepcopy(i)
		local ac = vim.deepcopy(a)
		for key, name in pairs({ n = "Next", l = "Last" }) do
			i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
			a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
		end
		require("which-key").register({
			mode = { "o", "x" },
			i = i,
			a = a,
		})
	end)
end
--#endregion

return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
					load_textobjects = true
				end,
			},
			{
				"nvim-treesitter/nvim-treesitter-context",
				event = { "BufReadPost", "BufNewFile" },
				opts = { enable = true },
			},
		},
		cmd = { "TSUpdateSync" },
		keys = {
			{ "<C-space>", desc = "Increment selection" },
			{ "<BS>", desc = "Decrement selection", mode = "x" },
		},
		opts = ts_opts,
		---@param opts TSConfig
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			if load_textobjects then
				-- PERF: no need to load the plugin, if we only need its queries for mini.ai
				disable_textobjects(opts)
			end
		end,
	},

	-- Better text objects
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter-textobjects" },
		opts = miniai_opts,
		config = function(_, opts)
			require("mini.ai").setup(opts)
			-- register all text objects with which-key
			register_textobjects_keys()
		end,
	},
}
