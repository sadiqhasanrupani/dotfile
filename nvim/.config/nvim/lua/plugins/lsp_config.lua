return {

  -- mason setup
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },

  -- mason lsp setup
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
      ensure_installed = { "gopls", "tailwindcss", "lua_ls", "intelephense", "jdtls", "pyright" },
    },
    config = function() end,
  },

  -- neo vim lsps setup
  {
    "neovim/nvim-lspconfig",
    -- opts = {
    --   servers = {
    --     tailwindcss = {},
    --   },
    -- },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require "lspconfig"

      lspconfig.lua_ls.setup { capabilities = capabilities }
      lspconfig.ts_ls.setup { capabilities = capabilities }
      lspconfig.dockerls.setup { capabilities = capabilities }
      lspconfig.docker_compose_language_service.setup { capabilities = capabilities }
      lspconfig.sqlls.setup { capabilities = capabilities }
      lspconfig.cssls.setup { capabilities = capabilities }
      lspconfig.gopls.setup { capabilities = capabilities }
      lspconfig.tailwindcss.setup { capabilities = capabilities }
      lspconfig.dartls.setup { capabilities = capabilities }
      lspconfig.solargraph.setup { capabilities = capabilities }
      lspconfig.yamlls.setup { capabilities = capabilities }
      lspconfig.ruby_lsp.setup { capabilities = capabilities }
      -- lspconfig.html_lsp.setup { capabilities = capabilities }
      lspconfig.intelephense.setup { capabilities = capabilities }
      lspconfig.jdtls.setup { capabilities = capabilities }
      lspconfig.pyright.setup { capabilities = capabilities }

      -- require("mason-lspconfig").setup_handlers {
      --
      --   function(server_name)
      --     if server_name ~= "jdtls" then
      --       lspconfig[server_name].setup {
      --         capabilities = capabilities,
      --       }
      --     end
      --   end,
      -- }

      -- lspconfig.ast_grep.setup({})
      -- lspconfig.zls.setup({})
      -- lspconfig.biome.setup({})
      -- lspconfig.vuels.setup({ capabilities = capabilities })

      -- keybindings for lsp
      require "keymaps.lsp-keybinds"
    end,
  },

  -- comment setup

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
}
