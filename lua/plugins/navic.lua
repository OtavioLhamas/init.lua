local navic_opts = function()
    return {
        depth_limit = 0,
        depth_limit_indicator = '..',
        highlight = true,
        icons = require("util.icons").navic,
        safe_output = true,
        separator = ' > ',
    }
end

return {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
        vim.g.navic_silence = true
        require("util").on_attach(function(client, buffer)
            if client.server_capabilities.documentSymbolProvider then
                require("nvim-navic").attach(client, buffer)
            end
        end)
    end,
    opts = navic_opts
}
