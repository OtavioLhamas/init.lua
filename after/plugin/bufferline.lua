vim.opt.showtabline = 2

require('bufferline').setup({
    options = {
        mode = 'buffers',
        themable = true,
        numbers = 'both',
        close_command = function(bufnr)
            require('otaviolhamas.global').buf_kill('bd', bufnr, false)
        end,
        diagnostics = 'nvim_lsp',
        offsets = {
            {
                filetype = "undotree",
                text = "Undotree",
                highlight = "PanelHeading",
                padding = 1,
            },
            {
                filetype = "DiffviewFiles",
                text = "Diff View",
                highlight = "PanelHeading",
                padding = 1,
            },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_buffer_default_icon = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = 'thin',
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = 'id',
    }
})
