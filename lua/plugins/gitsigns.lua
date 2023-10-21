return {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
        local on_attach = opts.on_attach
        local borders = require("lazyvim.config").icons.borders

        opts = vim.tbl_deep_extend("force", opts, {
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
                on_attach()

                local gs = package.loaded.gitsigns
                vim.keymap.set("n", "<leader>ghl", gs.toggle_current_line_blame, { desc = "Toggle Blame Line" })
            end,
            preview_config = {
                -- Options passed to nvim_open_win
                border = {
                    borders.thin.top_left,
                    borders.thin.top,
                    borders.thin.top_right,
                    borders.thin.right,
                    borders.thin.bottom_right,
                    borders.thin.bottom,
                    borders.thin.bottom_left,
                    borders.thin.left,
                },
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
        })

        return opts
    end,
}
