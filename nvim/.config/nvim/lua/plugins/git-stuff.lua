return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      -- keybindings
      require("keymaps.gitsigns-keymap")
    end,
  },
  {
    "tpope/vim-fugitive",
  },
}
