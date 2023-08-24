local Util = require("util")
local thin = require("util.icons").borders.thin

local function set_terminal_keymaps()
    Util.map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
    Util.map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
    Util.map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
    Util.map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
    Util.map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
end

local toggleterm_opts = {
	open_mapping = [[<c-/>]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	persist_size = false,
	-- direction = 'vertical' | 'horizontal' | 'window' | 'float',
	direction = "float",
	close_on_exit = true, -- close the terminal window when the process exits
	shell = vim.o.shell, -- change the default shell
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- The border key is *almost* the same as 'nvim_win_open'
		-- see :h nvim_win_open for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		-- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
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
		-- width = <value>,
		-- height = <value>,
		winblend = 3,
	},
    highlights = {
        Normal = {
            guibg = "#16161e"
        },
        NormalFloat = {
            guibg = "#16161e"
        },
        FloatBorder = {
            guibg = "#16161e"
        }
    }
}
return {
	"akinsho/toggleterm.nvim",
	keys = {
		{
			"<C-/>",
			"<cmd>ToggleTerm<cr>",
			desc = "Toggle Terminal",
		},
        {
            "<leader>t",
            "<cmd>exe v:count1 'ToggleTerm direction=horizontal'<cr>"
        }
	},
    init = function()
        vim.api.nvim_create_autocmd("TermOpen", {
            callback = function()
                set_terminal_keymaps()
            end,
        })
    end,
	opts = toggleterm_opts,
}
