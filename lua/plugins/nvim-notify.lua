return {
    "rcarriga/nvim-notify",
    opts = {
        on_open = function(win)
            local border = require("util").icons.border
            local config = vim.api.nvim_win_get_config(win)

            config.border = {
                border.thin.top_left,
                border.thin.top,
                border.thin.top_right,
                border.thin.right,
                border.thin.bottom_right,
                border.thin.bottom,
                border.thin.bottom_left,
                border.thin.left,
            }

            vim.api.nvim_win_set_config(win, config)
        end,
    },
}
