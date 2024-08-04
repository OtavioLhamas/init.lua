return {
    "nvim-treesitter",
    opts = function(_, opts)
        table.insert(opts.ensure_installed, {
            "c_sharp",
            "rust",
        })

        vim.filetype.add({
            extension = { rasi = "rasi" },
            pattern = {
                [".*/kitty/*.conf"] = "bash",
            },
        })

        return opts
    end,
}
