vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree' })

-- if set, let undotree window get focus after being opened, otherwise
-- focus will stay in current window.
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_WindowLayout = 2
