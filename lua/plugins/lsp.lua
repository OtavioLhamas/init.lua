--#region global capabilities
local function setup_capabilities()
    local Util = require("lazyvim.util")
    local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

    if Util.has("cmp-nvim-lsp") then
        lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
    end

    if Util.has("nvim-ufo") then
        lsp_capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
    end

    -- merge vim.lsp, cmp_nvim_lsp, and opts.capabilities tables in a single variable
    return vim.tbl_deep_extend("force", {}, lsp_capabilities, has_cmp and cmp_nvim_lsp.default_capabilities() or {})
end
--#endregion

return {
    {
        "neovim/nvim-lspconfig",
        init = function()
            local keys = require("lazyvim.plugins.lsp.keymaps").get()
            keys[#keys + 1] = { "gl", vim.diagnostic.open_float, desc = "Line Diagnosctics" }
        end,
        opts = function(_, opts)
            local icons = require("lazyvim.config").icons
            opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics, {
                float = {
                    border = {
                        icons.borders.thin.top_left,
                        icons.borders.thin.top,
                        icons.borders.thin.top_right,
                        icons.borders.thin.right,
                        icons.borders.thin.bottom_right,
                        icons.borders.thin.bottom,
                        icons.borders.thin.bottom_left,
                        icons.borders.thin.left,
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
                    prefix = "",
                },
            })

            opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities, setup_capabilities())

            local omnisharp = {
                settings = {
                    FormattingOptions = {
                        EnableEditorConfigSupport = true,
                        OrganizeImports = true,
                    },
                    MsBuild = {
                        LoadProjectsOnDemand = nil,
                    },
                    RoslynExtensionsOptions = {
                        EnableAnalyzersSupport = true,
                        EnableImportCompletion = true,
                        AnalyzeOpenDocumentsOnly = nil,
                    },
                    Sdk = {
                        IncludePrereleases = true,
                    },
                },
                on_attach = function(_, bufnr)
                    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
                end,
            }

            local volar = {
                filetypes = { 'vue' },
                init_options = {
                    vue = {
                        hybridMode = false
                    }
                }
            }

            local tsserver = {
                settings = {
                    javascript = {
                        format = {
                            semicolons = "insert",
                        },
                        preferences = {
                            quoteStyle = "single",
                        },
                    },
                },
            }

            if vim.loop.os_uname().sysname == "Windows" then
                omnisharp.cmd = {
                    "dotnet",
                    os.getenv("LOCALAPPDATA") .. "\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.dll",
                    "--languageserver",
                    "--hostPID",
                    tostring(vim.fn.getpid()),
                }
            end

            opts.servers = vim.tbl_deep_extend("force", opts.servers, {
                html = {},
                jsonls = {},
                omnisharp = omnisharp,
                rust_analyzer = {},
                volar = volar,
                tsserver = tsserver,
                yamlls = {},
            })
        end,
    },
}
