return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      --[[
      catppuccin flavours =>
        -- light scheme => catppuccin-latte
        -- black scheme => catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
       --]]

      require("catppuccin").setup {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        -- flavour = "latte", -- latte, frappe, macchiato, mocha
        -- transparent_background = true,

        -- integration
        integration = {
          neotree = true,
          telescope = true,
        },
      }

      vim.cmd.colorscheme "catppuccin"
    end,
  },
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   priority = 1000,
  --   config = function()
  --     require("onedarkpro").setup {
  --       highlights = {
  --         Comment = { link = "Substitute" },
  --       },
  --     }
  --   end,
  -- },
}
