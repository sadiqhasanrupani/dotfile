-- Go filetype configuration
-- Use native Vim syntax highlighting instead of treesitter

-- Disable treesitter for this buffer
vim.treesitter.stop()

-- Enable syntax highlighting
vim.cmd('syntax enable')

-- Go-specific settings
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false -- Go uses tabs
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true

-- Set commentstring for Go
vim.opt_local.commentstring = "// %s"

-- Enable Go syntax highlighting if available
if vim.fn.exists('*go#config#GoplsEnabled') == 1 then
    vim.cmd('runtime! syntax/go.vim')
end
