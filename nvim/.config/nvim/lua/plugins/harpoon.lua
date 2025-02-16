return {
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup {
        global_settings = {
          save_on_toggle = false,
          save_on_change = true,
          enter_on_sendcmd = false,
          tmux_autoclose_windows = false,
          excluded_filetypes = {
            "harpoon",
          },
          mark_branch = false,
          tabline = false,
          tabline_prefix = "   ",
          tabline_suffix = "   ",
        },
      }

      -- keymaps
      vim.keymap.set("n", "<leader>hq", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {})

      -- add files into harpoon
      vim.keymap.set("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>", {})

      -- remove a file from harpoon
      vim.keymap.set("n", "<leader>q", ":lua require('harpoon.mark').rm_file()<CR>", {})

      -- navigate to harpoon files
      vim.keymap.set("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", {})
      vim.keymap.set("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", {})
      vim.keymap.set("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", {})
      vim.keymap.set("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", {})
      vim.keymap.set("n", "<leader>5", ":lua require('harpoon.ui').nav_file(5)<CR>", {})
      vim.keymap.set("n", "<leader>6", ":lua require('harpoon.ui').nav_file(6)<CR>", {})
      vim.keymap.set("n", "<leader>7", ":lua require('harpoon.ui').nav_file(7)<CR>", {})
      vim.keymap.set("n", "<leader>8", ":lua require('harpoon.ui').nav_file(8)<CR>", {})
      vim.keymap.set("n", "<leader>9", ":lua require('harpoon.ui').nav_file(9)<CR>", {})
      vim.keymap.set("n", "<leader>hn", ":lua require('harpoon.ui').nav_next()<CR>", {})
      vim.keymap.set("n", "<leader>hp", ":lua require('harpoon.ui').nav_prev()<CR>", {})
      vim.keymap.set("n", "<leader>hm", ":Telescope harpoon marks<CR>", {})
    end,
  },
}
