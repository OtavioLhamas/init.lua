return {
    "nvim-lspconfig",
    opts = {
        --#region LSP diagnostics
        diagnostics = {

            --#region Float window (<leader>gl)
            float = {
                focusable = true,
                header = "",
                prefix = "",
                severity_sort = true,
                style = "minimal",
            },
            --#endregion

            --#region Virtual text
            virtual_text = {
                spacing = 4,
                source = "if_many",
                severity = { min = vim.diagnostic.severity.WARN },
                prefix = "icons",
            },
            --#endregion
        },
        --#endregion

        --#region Server specific opts
        servers = {
            ["*"] = { -- all servers
                keys = {
                    { "gl", vim.diagnostic.open_float, desc = "Line Diagnosctics" },
                },
            },
        },
        --#endregion
    },
}
