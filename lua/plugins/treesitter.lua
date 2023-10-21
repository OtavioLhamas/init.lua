return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            table.insert(opts.ensure_installed, {
                "c_sharp",
                "go",
                "rust"
            })

            vim.filetype.add({
                extension = { rasi = "rasi" },
                pattern = {
                    [".*/kitty/*.conf"] = "bash",
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            vim.cmd([[hi TreesitterContext gui=NONE]])
        end,
    },
}
