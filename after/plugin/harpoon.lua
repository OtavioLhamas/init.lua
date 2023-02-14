local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>aa", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

require('harpoon').setup({})
