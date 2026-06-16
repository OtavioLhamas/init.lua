return {
    "nvim-treesitter",
    opts = function(_, opts)
        opts.ensure_installed = LazyVim.merge(opts.ensure_installed, {
            "css",
            "scss",

            "fish",

            "groovy",

            "html",

            "jinja",
            "gotmpl",
            "yaml",
            "toml",

            "powershell",

            "bash",

            "xml",
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
