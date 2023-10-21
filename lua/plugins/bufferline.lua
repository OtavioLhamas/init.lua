return {
    {
        "akinsho/bufferline.nvim",
        opts = function(_, opts)
            opts.options = vim.tbl_deep_extend("force", opts.options, {
                color_icons = true,
                enforce_regular_tabs = false,
                mode = "buffers",
                numbers = "both",
                persist_buffer_sort = true,
                separator_style = "thin",
                themable = true,
            })
        end,
    },
}
