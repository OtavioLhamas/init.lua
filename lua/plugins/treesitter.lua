return {
    "nvim-treesitter",
    opts = function(_, opts)
        opts.ensure_installed = LazyVim.merge(opts.ensure_installed, {
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

