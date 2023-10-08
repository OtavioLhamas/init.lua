local M = {}
local Util = require("lazy.core.util")

--#region tokyonight
local tokyo_opts = {
	style = "night",
	on_highlights = function(hl, c)
		local prompt = "#2d3149"

		hl.NoiceCmdlinePopup = {
			bg = c.bg_dark,
		}
		hl.NoiceCmdlinePopupBorder = {
			bg = c.bg_dark,
			fg = c.fg_dark,
		}
		hl.NoiceCmdlinePopupTitle = {
			bg = c.bg_dark,
			fg = c.blue2,
		}

		hl.TelescopeNormal = {
			bg = c.bg_float,
			fg = c.fg_float,
		}
		hl.TelescopeBorder = {
			bg = c.bg_dark,
			fg = c.fg_dark,
		}
		hl.TelescopePreviewBorder = {
			bg = c.bg_highlight,
			fg = c.fg_dark,
		}
		hl.TelescopePreviewNormal = {
			bg = c.bg_highlight,
		}
		hl.TelescopePreviewTitle = {
			bg = c.bg_highlight,
			fg = c.blue2,
		}
		hl.TelescopePromptBorder = {
			bg = c.bg_highlight,
			fg = c.fg_dark,
		}
		hl.TelescopePromptNormal = {
			bg = c.bg_highlight,
		}
		hl.TelescopePromptTitle = {
			bg = c.bg_highlight,
			fg = c.blue2,
		}
		hl.TelescopeSelection = {
			bg = c.blue0,
		}
		-- hl.TelescopeResultsTitle = {
		--     bg = c.bg_dark,
		--     fg = c.bg_dark,
		-- }
		hl.TelescopeResultsBorder = {
			bg = c.bg_float,
			fg = c.fg_dark,
		}
	end,
}
--#endregion

--#region monokai-pro
local monokai_opts = {
	transparent_background = true,
	terminal_colors = true,
	devicons = true, -- highlight the icons of `nvim-web-devicons`
	styles = {
		comment = { italic = false },
		keyword = { italic = false }, -- any other keyword
		type = { italic = false }, -- (preferred) int, long, char, etc
		storageclass = { italic = false }, -- static, register, volatile, etc
		structure = { italic = false }, -- struct, union, enum, etc
		parameter = { italic = false }, -- parameter pass in function
		annotation = { italic = false },
		tag_attribute = { italic = false }, -- attribute of tag in reactjs
	},
	filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
	-- Enable this will disable filter option
	day_night = {
		enable = false, -- turn off by default
		day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
		night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
	},
	inc_search = "background", -- underline | background
	background_clear = {
		"float_win",
		"toggleterm",
		"telescope",
		"which-key",
		"renamer",
		"notify",
		"nvim-tree",
		-- "neo-tree",
		-- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
	}, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
	plugins = {},
	---@param c Colorscheme
	override = function(c) end,
}
--#endregion

--#region catppuccin
local catppuccin_opts = {
    flavour = "mocha",
    background = {
        light = "latte",
        dark = "mocha",
    },
    highlight_overrides = {
        mocha = function(mocha)
            return {
                LazyNormal = {
                    bg = mocha.crust,
                },

                NoiceCmdlinePopup = {
                    bg = mocha.mantle,
                },
                NoiceCmdlinePopupBorder = {
                    bg = mocha.mantle,
                    fg = mocha.overlay0
                },
                NoiceCmdlinePopupTitle = {
                    fg = mocha.subtext1,
                },

                NoicePopup = {
                    bg = mocha.mantle,
                },
                NoicePopupBorder = {
                    bg = mocha.mantle,
                    fg = mocha.overlay0,
                },
                NoicePopupTitle = {
                    fg = mocha.subtext1
                },

                NotifyBackground = {
                    bg = mocha.mantle,
                },

                NvimTreeNormal = {
                    bg = "NONE",
                },

                NormalFloat = {
                    bg = mocha.mantle,
                },

                TelescopeNormal = {
                    bg = mocha.crust,
                },
                TelescopeBorder = {
                    bg = mocha.crust,
                    fg = mocha.overlay0,
                },
                TelescopePreviewNormal = {
                    bg = mocha.crust,
                },
                TelescopePreviewBorder = {
                    bg = mocha.crust,
                    fg = mocha.overlay0,
                },
                TelescopePromptNormal = {
                    bg = mocha.crust,
                },
                TelescopePromptBorder = {
                    bg = mocha.crust,
                    fg = mocha.overlay0,
                },
                TelescopePromptTitle = {
                    fg = mocha.subtext1,
                },
                TelescopeResultsNormal = {
                    bg = mocha.base,
                },
                TelescopeResultsBorder = {
                    bg = mocha.base,
                    fg = mocha.overlay0,
                },
            }
        end,
    },
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        nvimtree = false,
        treesitter = true,
        mason = true,
        mini = true,
        navic = { enabled = true, custom_bg = "NONE" },
        noice = true,
        notify = true,
        telescope = { enabled = true },
        trouble = false,
        ufo = true,
        which_key = true,
    },
    term_colors = true,
    transparent_background = true,
}
--#endregion

return {
	-- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			local ok, tokyonight = pcall(require, "tokyonight")
			if not ok then
				return
			end

			-- tokyonight.setup(tokyo_opts)
			-- vim.cmd.colorscheme("tokyonight-night")
		end,
	},

	-- monokai-pro
	{
		"loctvl842/monokai-pro.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			local ok, monokai = pcall(require, "monokai-pro")
			if not ok then
				return
			end

			-- monokai.setup(monokai_opts)
			-- vim.cmd.colorscheme("monokai-pro")
		end,
	},

	-- sonokai
	{
		"sainnhe/sonokai",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("let g:sonokai_transparent_background = 1")
			vim.cmd("let g:sonokai_better_performance = 1")

			-- vim.cmd.colorscheme("sonokai")
		end,
	},

    -- catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function ()
			local ok, catppuccin = pcall(require, "catppuccin")
			if not ok then
				return
			end

            catppuccin.setup(catppuccin_opts)
            vim.cmd.colorscheme("catppuccin-mocha")
        end
    }
}
