local icons = require("util.icons")

local function tree_opts()
    return {
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = icons.diagnostics.hint,
                info = icons.diagnostics.info,
                warning = icons.diagnostics.warn,
                error = icons.diagnostics.error,
            },
        },
        hijack_cursor = true,
        modified = {
            enable = true,
        },
        renderer = {
            group_empty = true,
            indent_markers = { enable = true },
            icons = {
                git_placement = "after",
                glyphs = {
                    git = {
                        unstaged = icons.git.unstaged,
                        staged = icons.git.staged,
                        unmerged = icons.git.conflict,
                        renamed = icons.git.renamed,
                        untracked = icons.git.untracked,
                        deleted = icons.git.deleted,
                        ignored = icons.git.ignored,
                    },
                },
            },
        },
        respect_buf_cwd = false,
        sync_root_with_cwd = false,
        update_focused_file = {
            enable = true,
            update_root = true
        },
        view = {
            number = true,
            relativenumber = true,
            width = 40,
        },
        filters = {
            git_ignored = false,
            dotfiles = false,
        },
    }
end

return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		cmd = "NvimTreeToggle",
		keys = {
			{ "<leader>;", "<cmd>NvimTreeToggle<cr>", desc = "Explore" },
		},
		opts = tree_opts,
	},
}
