return {
    "nvim-lspconfig",
    init = function()
        local keys = require("lazyvim.plugins.lsp.keymaps").get()
        keys[#keys + 1] = { "gl", vim.diagnostic.open_float, desc = "Line Diagnosctics" }
    end,
    opts = function(_, opts)
        local border = require("util").icons.border

        -- configure lsp to use nvim-ufo folding
        local lsp_capabilities = {}
        if LazyVim.has("nvim-ufo") then
            lsp_capabilities.textDocument = {
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true,
                },
            }
        end
        opts.capabilities = LazyVim.merge(opts.capabilities, lsp_capabilities)

        opts.diagnostics = LazyVim.merge(opts.diagnostics, {
            float = {
                border = {
                    border.thin.top_left,
                    border.thin.top,
                    border.thin.top_right,
                    border.thin.right,
                    border.thin.bottom_right,
                    border.thin.bottom,
                    border.thin.bottom_left,
                    border.thin.left,
                },
                focusable = false,
                header = "",
                prefix = "",
                severity_sort = true,
                style = "minimal",
            },
            virtual_text = {
                spacing = 4,
                source = "if_many",
                severity = { min = vim.diagnostic.severity.WARN },
                prefix = "icons",
            },
        })

        -- TODO: configure LSP servers as needed

        return opts
    end,
}
