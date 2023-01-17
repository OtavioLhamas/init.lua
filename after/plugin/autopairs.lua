local npairs = require('nvim-autopairs')
local ntags = require('nvim-ts-autotag')

npairs.setup({
    enable_check_bracket_line = true,
    check_ts = true,
})

ntags.setup()
