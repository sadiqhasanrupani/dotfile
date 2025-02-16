return {
  { "tpope/vim-rails" },
  { "tpope/vim-bundler" },
  { "tpope/vim-endwise" },
  { "tpope/vim-rake" },
  { "tpope/vim-surround" },
  { "vim-ruby/vim-ruby" },
  { "Shougo/deoplete.nvim" },
  {
    "weizheheng/ror.nvim",
    config = function()
      require("ror").setup {
        test = {
          message = {
            file = "Running test file...",
            line = "Running single test...",
          },
          coverage = {
            up = "DiffAdd",
            down = "DiffDelete",
          },
          notification = {
            timeout = false,
          },
          pass_icon = "✅",
          fail_icon = "❌",
        },
      }

      -- This "list_commands()" will show a list of all the available commands to run
      vim.keymap.set("n", "<Leader>rc", ":lua require('ror.commands').list_commands()<CR>", { silent = true })
    end,
  },
}
