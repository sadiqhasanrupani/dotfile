return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "dracula"
      }
    })
  end
}

-- return {
--   "nvim-lualine/lualine.nvim",
--   config = function()
--     require("lualine").setup {
--       options = {
--         theme = require "lualine.themes.dracula", -- Load the dracula theme
--       },
--     }
--
--     -- Make the lualine background transparent
--     local dracula_theme = require "lualine.themes.dracula"
--     for _, mode in pairs(dracula_theme) do
--       if mode.a then
--         mode.a.bg = "NONE"
--       end
--       if mode.b then
--         mode.b.bg = "NONE"
--       end
--       if mode.c then
--         mode.c.bg = "NONE"
--       end
--     end
--
--     require("lualine").setup {
--       options = {
--         theme = dracula_theme, -- Use the modified theme
--       },
--     }
--   end,
-- }
