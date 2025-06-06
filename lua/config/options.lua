-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.deprecation_warnings = true
vim.g.autoformat = false
vim.g.snacks_animate = false
vim.g.lazyvim_prettier_needs_config = true

if LazyVim.is_win() then
    -- Try to get PowerShell version, redirecting stderr to null
    local powershell_version_output = vim.fn.system('powershell.exe -Command "$PSVersionTable.PSVersion.Major" 2>$null')

    -- Trim whitespace and newlines from the output
    local major_version = string.match(powershell_version_output, "^%s*(%d+)%s*$")

    vim.o.shell = (major_version and tonumber(major_version) >= 7) and "pwsh.exe" or "powershell.exe"
else
    vim.o.shell = "fish"
end

local opt = vim.opt
local b = vim.b

b.autoformat = false

opt.clipboard = ""
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.conceallevel = 0 -- Text is shown normally
-- opt.foldcolumn = "0" -- disable foldcolumn
-- opt.foldenable = true
-- opt.foldlevel = 99 -- using ufo provider needs a large value
-- opt.foldlevelstart = 99
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.shiftwidth = 4 -- number of spaces to use for each step of (auto)indent
opt.softtabstop = 4 -- number of spaces tabs counts for while performing editing operations
opt.tabstop = 4 -- number of spaces tabs count for
opt.wrap = true -- enable line wrap
