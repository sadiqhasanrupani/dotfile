return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TsUpdate",
    build = ":TsUpdate",
    config = function()
      local treeSConfig = require "nvim-treesitter.configs"
      treeSConfig.setup {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
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
    end,
  },
}
