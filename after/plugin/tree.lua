require('nvim-tree').setup({
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
        },
    },
    hijack_cursor = true,
    modified = {
        enable = true,
    },
    renderer = {
        indent_markers = { enable = true },
        icons = {
            git_placement = 'after',
        },
    },
    update_focused_file = {
        enable = true,
    },
    view = {
        number = true,
        relativenumber = true,
        width = 40
    }
})

