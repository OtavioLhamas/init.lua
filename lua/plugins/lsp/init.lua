local Util = require("util")
local icons = require("util.icons")
local thin = icons.borders.thin

local lsp_settings = {}
local lsp_onattach = {}
local lsp_filetypes = {}
local lsp_keys = {}

--#region lspconfig
local lsp_servers = {
	"ansiblels",
	"bashls",
	"cssls",
	"emmet_ls",
	"html",
	"jsonls",
	"lua_ls",
	"omnisharp",
	"rust_analyzer",
	"tsserver",
	"yamlls",
}

--#region settings
-- Automatically format on save
lsp_settings.autoformat = false
-- Enable this to show formatters used in a notification
-- Useful for debugging formatter issues
lsp_settings.format_notify = true
-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
-- Be aware that you also will need to properly configure your LSP server to
-- provide the inlay hints.
lsp_settings.enable_inlayhint = false

--#region lua_ls
lsp_settings.lua_ls = {
	Lua = {
		diagnostics = {
			globals = { "vim" },
		},
		workspace = {
			checkThirdParty = false,
		},
		completion = {
			-- callSnippet = "Replace",
		},
	},
}
--#endregion

--#endregion

--#region diagnostics
local function setup_diagnostics()
	-- sign icons
	for name, icon in pairs(icons.diagnostics) do
		name = "DiagnosticSign" .. name
		vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
	end

	-- options for vim.diagnostic.config()
	local diagnostics = {
		float = {
			border = {
				thin.top_left,
				thin.top,
				thin.top_right,
				thin.right,
				thin.bottom_right,
				thin.bottom,
				thin.bottom_left,
				thin.left,
			},
			focusable = false,
			header = "",
			prefix = "",
			severity_sort = true,
			style = "minimal",
		},
		severity_sort = true,
		underline = true,
		update_in_insert = false,
		virtual_text = {
			severity = { min = vim.diagnostic.severity.WARN }, -- no text for hints
			spacing = 2,
			source = "if_many",
		},
	}

	if type(diagnostics.virtual_text) == "table" and diagnostics.virtual_text.prefix == "icons" then
		diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
			or function(diagnostic)
				for d, icon in pairs(icons.diagnostics) do
					if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
						return icon
					end
				end
			end
	end

	vim.diagnostic.config(vim.deepcopy(diagnostics))
end
--#endregion

--#region inlay hints
local function setup_inlayhints()
	local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

	if inlay_hint then
		Util.on_attach(function(client, buffer)
			if client.supports_method("textDocument/inlayHint") then
				inlay_hint(buffer, true)
			end
		end)
	end
end
--#endregion

--#region global capabilities
local capabilities = {}
local function setup_capabilities()
	local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
	local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

	if Util.has("cmp-nvim-lsp") then
		lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
	end

	if Util.has("nvim-ufo") then
		lsp_capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
	end

	-- merge vim.lsp, cmp_nvim_lsp, and opts.capabilities tables in a single variable
	capabilities =
		vim.tbl_deep_extend("force", {}, lsp_capabilities, has_cmp and cmp_nvim_lsp.default_capabilities() or {})
end
--#endregion

--#region lsps
local function server_setup(server)
	local config = {
		capabilities = capabilities,
		settings = lsp_settings[server],
		on_attach = lsp_onattach[server],
		filetypes = lsp_filetypes[server],
	}

	require("lspconfig")[server].setup(config)
end

local function setup_all_lsps()
	-- setup autoformat
	require("plugins.lsp.format").setup(lsp_settings)
	-- setup formatting and keymaps
	Util.on_attach(function(client, buffer)
		require("plugins.lsp.keymaps").on_attach(client, buffer)
	end)

	for _, lsp in pairs(lsp_servers) do
		server_setup(lsp)
	end
end
--#endregion

--#endregion

--#region mason
local mason_opts = {
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
    ui = {
        border = {
            thin.top_left,
            thin.top,
            thin.top_right,
            thin.right,
            thin.bottom_right,
            thin.bottom,
            thin.bottom_left,
            thin.left,
        },
        height = 0.8,
    },
}
--#endregion

return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
			{ "folke/neodev.nvim", opts = {} },
			"mason.nvim",
			"mason-lspconfig.nvim",
			{
				"hrsh7th/cmp-nvim-lsp",
				cond = function()
					return require("util").has("nvim-cmp")
				end,
			},
		},
		init = setup_all_lsps,
		opts = {
			lspSettings = lsp_settings,
			lspOnAttach = lsp_onattach,
			lspFiletypes = lsp_filetypes,
			lspKeys = lsp_keys,
		},
		config = function(_, _)
			if Util.has("neodev.nvim") then
				require("neodev").setup({})
			end

			if Util.has("neoconf.nvim") then
				local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
				require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
			end

			setup_diagnostics()
			if lsp_settings.enable_inlayhint then
				setup_inlayhints()
			end
			setup_capabilities()
			setup_all_lsps()
		end,
	},

	-- formatters
	{
		-- TODO replace null-ls with whatever folke does in LazyVim
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")
			return {
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
				sources = {
					nls.builtins.formatting.fish_indent,
					nls.builtins.diagnostics.fish,
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.shfmt,
				},
			}
		end,
	},

	-- cmdline tools and lsp servers
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = mason_opts,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		dependencies = "williamboman/mason.nvim",
		opts = { ensure_installed = lsp_servers },
	},
}
