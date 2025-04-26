return {
    "nvim-lspconfig",
    opts = function(_, opts)
        local keys = require("lazyvim.plugins.lsp.keymaps").get()

        keys[#keys + 1] = { "gl", vim.diagnostic.open_float, desc = "Line Diagnosctics" }

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

        opts.codelens = LazyVim.merge(opts.codelens, { enabled = false })

        opts.diagnostics = LazyVim.merge(opts.diagnostics, {
            float = {
                border = "rounded",
                focusable = true,
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

