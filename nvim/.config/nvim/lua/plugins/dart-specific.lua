return {
  -- { "dart-lang/dart-vim-plugin" },
  -- { "thosakwe/vim-flutter" },
  -- { "natebosch/vim-lsc" },
  -- { "natebosch/vim-lsc-dart" },
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("flutter-tools").setup({
        decorations = {
          statusline = {
            -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
            -- this will show the current version of the flutter app from the pubspec.yaml file
            app_version = true,
            -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
            -- this will show the currently running device if an application was started with a specific
            -- device
            device = true,
            -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
            -- this will show the currently selected project configuration
            project_config = true,
          },
        },
        dev_tools = {
          autostart = true, -- autostart devtools server if not detected
          auto_open_browser = true, -- Automatically opens devtools in the browser
        },
        outline = {
          open_cmd = "30vnew", -- command to use to open the outline buffer
          auto_open = true, -- if true this will open the outline automatically when it is first populated
        },
        widget_guides = {
          enabled = true, -- Enable widget guides for Flutter widgets
        },
        lsp = {
          on_attach = function(client, bufnr)
            -- Additional LSP settings can be set here
          end,
          capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        },
      })
    end,
  },
}
