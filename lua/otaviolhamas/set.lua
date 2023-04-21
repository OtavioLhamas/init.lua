vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = false

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false

-- Save undo history
vim.opt.undodir = os.getenv('LOCALAPPDATA') .. '/nvim-data/undodir'
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set highlight on search
vim.opt.hlsearch = true

-- Enable mouse mode
vim.opt.mouse = 'a'

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.signcolumn = 'yes'

vim.opt.colorcolumn = '100'

-- timeout controls which-key plugin
vim.opt.timeout = true
vim.opt.timeoutlen = 300

vim.opt.foldcolumn = '0' -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
