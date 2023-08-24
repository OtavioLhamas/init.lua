local thin = require("util.icons").borders.thin

local function on_attach(buffer)
	local gs = package.loaded.gitsigns

	local function map(mode, l, r, desc)
		vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
	end

    -- stylua: ignore start
    map("n", "]h", gs.next_hunk, "Next Hunk")
    map("n", "[h", gs.prev_hunk, "Prev Hunk")
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
    map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
    map("n", "<leader>ghd", gs.diffthis, "Diff This")
    map("n", "<leader>ghl", gs.toggle_current_line_blame, "Toggle Blame Line")
    map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
    map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
    map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
    map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
end

local gitsigns_opts = {
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
        relative_time = false,
    },
    on_attach = function(buffer)
        on_attach(buffer)
    end,
    preview_config = {
        -- Options passed to nvim_open_win
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
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "▎" },
    },
}

return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = gitsigns_opts,
	},
}
