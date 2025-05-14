vim.cmd "set expandtab"
vim.cmd "set tabstop=2"
vim.cmd "set softtabstop=2"
vim.cmd "set shiftwidth=2"
vim.cmd "set number"
vim.cmd "set relativenumber"
-- vim.cmd "set guicursor="
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "<Leader>cp", ":w !xclip -selection clipboard<CR>", { desc = "For Clipboard" })

-- Navigate vim panes in a better way
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.g.mapleader = " "

vim.filetype.add {
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
}
