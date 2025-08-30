return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TsUpdate",
    build = ":TsUpdate",
    config = function()
      local treeSConfig = require "nvim-treesitter.configs"
      treeSConfig.setup {
        auto_install = false, -- Disable auto install
        highlight = { 
          enable = true,
          disable = { "go", "gomod", "gosum", "gowork" }, -- Completely disable Go-related highlighting
        },
        indent = { 
          enable = true,
          disable = { "go", "gomod", "gosum", "gowork" } -- Disable Go indentation as well
        },
        ensure_installed = { "ruby", "json", "php", "html", "python" },
      }

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }
      
      -- Create autocmd to force disable treesitter for Go files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "go", "gomod", "gosum", "gowork" },
        callback = function()
          vim.treesitter.stop()
        end,
      })
    end,
  },
}
