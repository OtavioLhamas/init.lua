---@class LazyKeys
---@field [1] string lhs
---@field [2]? string|fun()|false rhs
---@field desc? string
---@field mode? string|string[]
---@field noremap? boolean
---@field remap? boolean
---@field expr? boolean
---@field id string

local M = {}

M._keys = nil

function M.get()
	local format = function()
		require("plugins.lsp.format").format({ force = true })
	end
	if not M._keys then
		M._keys = {
			{
				"gl",
				vim.diagnostic.open_float,
				desc = "Line Diagnostics",
			},
			{
				"gd",
				function()
					require("telescope.builtin").lsp_definitions({ reuse_win = true })
				end,
				desc = "Definition",
				has = "definition",
			},
			{ "gD", vim.lsp.buf.declaration, desc = "Declaration" },
			{
				"gI",
				function()
					require("telescope.builtin").lsp_implementations({ reuse_win = true })
				end,
				desc = "Implementation",
			},
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{
				"gy",
				function()
					require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
				end,
				desc = "Type Definition",
			},
			{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signaturehelp" },
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "]d", M.diagnostic_goto(true), desc = "Next Diagnostic" },
			{ "[d", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
			{ "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
			{ "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
			{ "]w", M.diagnostic_goto(true, "WARN"), desc = "Next Warn" },
			{ "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warn" },
			{ "<A-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signaturehelp" },
			{ "<leader>cf", format, desc = "Format Document", has = "formatting" },
			{ "<leader>cf", format, desc = "Format Range", mode = "v", has = "formatting" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
			{
				"<leader>cA",
				function()
					vim.lsp.buf.code_action({
						context = {
							only = {
								"source",
							},
							diagnostics = {},
						},
					})
				end,
				desc = "Source Action",
				has = "codeAction",
			},
			{ "<leader>cl", vim.lsp.codelens.run, desc = "CodeLens Action" },
			{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
		}
	end
	return M._keys
end

---@param method string
function M.has(buffer, method)
	method = method:find("/") and method or "textDocument/" .. method
	local clients = vim.lsp.get_clients({ bufnr = buffer })
	for _, client in ipairs(clients) do
		if client.supports_method(method) then
			return true
		end
	end
	return false
end

function M.resolve(buffer)
	local Keys = require("lazy.core.handler.keys")
	local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

	local function add(keymap)
		local keys = Keys.parse(keymap)
		if keys[2] == false then
			keymaps[keys.id] = nil
		else
			keymaps[keys.id] = keys
		end
	end
	for _, keymap in ipairs(M.get()) do
		add(keymap)
	end

	-- lsp specific keymaps, defined in init.lua lspKeys
	local opts = require("util").opts("nvim-lspconfig")
	local clients = vim.lsp.get_clients({ bufnr = buffer })
	for _, client in ipairs(clients) do
		local maps = opts.lspKeys[client.name] or {}
		for _, keymap in ipairs(maps) do
			add(keymap)
		end
	end
	return keymaps
end

function M.on_attach(client, buffer)
	local Keys = require("lazy.core.handler.keys")
	local keymaps = M.resolve(buffer)

	for _, keys in pairs(keymaps) do
		if not keys.has or M.has(buffer, keys.has) then
			local opts = Keys.opts(keys)
			---@diagnostic disable-next-line: no-unknown
			opts.has = nil
			opts.silent = opts.silent ~= false
			opts.buffer = buffer
			vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
		end
	end
end

function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M
