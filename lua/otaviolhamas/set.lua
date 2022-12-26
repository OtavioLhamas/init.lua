vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

-- Save undo history
vim.opt.undodir = os.getenv('LOCALAPPDATA') .. '/nvim-data/undodir'
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set highlight on search
vim.o.hlsearch = false

-- Enable mouse mode
vim.opt.mouse = 'a'

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.signcolumn = 'yes'

vim.opt.colorcolumn = '100'
