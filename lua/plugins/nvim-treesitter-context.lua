return {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
        vim.cmd([[hi TreesitterContext gui=NONE]])
        vim.cmd([[hi TreesitterContextBottom gui=underline guisp=#cdd6f4]])
        vim.cmd([[hi TreesitterContextLineNumberBottom gui=underline guisp=#cdd6f4]])
    end,
}
