return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "muniftanjim/nui.nvim",
    "3rd/image.nvim",
    "catppuccin/nvim",
  },
  config = function()
    -- neo tree configs
    require("neo-tree").setup {
      filesystem = {
        filtered_items = {
          visible = true, -- this ensures the hidden files are visible
          hide_dotfiles = false, -- show dotfiles (hidden files starting with a dot)
          hide_gitignored = false, -- show files ignored by git
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.cmd "setlocal relativenumber"
          end,
        },
      },
    }

    -- Key mappings
    -- vim.keymap.set("n", "<c-n>", ":neotree toggle reveal right<cr>", {})
    vim.keymap.set("n", "<c-n>", ":Neotree toggle reveal left<cr>", {})
    vim.keymap.set("n", "<leader>e", ":Neotree focus<cr>", {})
  end,
}
