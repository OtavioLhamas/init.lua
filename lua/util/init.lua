local M = {}

M.icons = {
    clock = " ",
    indent = "│",
    git = {
        renamed = "➜",
        untracked = "",
        ignored = "",
        unstaged = "U",
        staged = "",
        conflict = "",
        deleted = "",
    },
    border = {
        empty = {
            top = " ",
            right = " ",
            bottom = " ",
            left = " ",
            top_left = " ",
            top_right = " ",
            bottom_right = " ",
            bottom_left = " ",
        },
        thick = {
            top = "▄",
            right = "█",
            bottom = "▀",
            left = "█",
            top_left = "▄",
            top_right = "▄",
            bottom_right = "▀",
            bottom_left = "▀",
        },
        thin = {
            top = "▔",
            right = "▕",
            bottom = "▁",
            left = "▏",
            top_left = "🭽",
            top_right = "🭾",
            bottom_right = "🭿",
            bottom_left = "🭼",
        },
    },
}

return M
