return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        event = "BufReadPost",
        init = function()
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
            vim.opt.foldenable = true
        end,
        opts = {
            provider_selector = function(_, ft, _)
                local lspWithoutFolding = { "markdown", "bash", "sh", "zsh", "css" }
                if vim.tbl_contains(lspWithoutFolding, ft) then
                    return { "treesitter", "indent" }
                elseif ft == "html" then
                    return { "indent" } -- lsp & treesitter do not provide folds
                else
                    return { "lsp", "indent" }
                end
            end,
            close_fold_kinds_for_ft = {
                default = { "imports", "region" },
                lua = {},
            },
            open_fold_hl_timeout = 500,
        },
    },
}
