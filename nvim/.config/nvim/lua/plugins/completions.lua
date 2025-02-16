return {
  -- cmp-nvim-lsp
  {
    "hrsh7th/cmp-nvim-lsp",
  },

  -- lua snip installation
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require "luasnip"
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      -- Add custom snippets for JavaScript and JSX
      ls.add_snippets("javascriptreact", {
        s("uquery", {
          t "const {",
          t {
            "",
            "  data: queryData,",
            "  isLoading: queryIsLoading,",
            "  isRefetching: queryIsRefetching,",
            "  error: queryError,",
            "  isError: queryIsError,",
            "  refetch: queryRefetch",
          },
          t { "", "} = useQuery({", "  queryKey: [" },
          i(1, ""),
          t "],",
          t {
            "",
            "  queryFn: fetchFunction,",
            "  gcTime: 0,",
            "  staleTime: Infinity",
            "})",
          },
        }),
      })

      -- Add custom snippets for TypeScript and TSX (React)
      ls.add_snippets("typescriptreact", {
        s("uquery", {
          t "const {",
          t {
            "",
            "  data: queryData,",
            "  isLoading: queryIsLoading,",
            "  isRefetching: queryIsRefetching,",
            "  error: queryError,",
            "  isError: queryIsError,",
            "  refetch: queryRefetch",
          },
          t { "", "} = useQuery<" },
          i(1, "type, type"),
          t { ">({", "  queryKey: [" },
          i(2, ""),
          t "],",
          t {
            "",
            "  queryFn: fetchFunction,",
            "  gcTime: 0,",
            "  staleTime: Infinity",
            "})",
          },
        }),
      })

      -- Optional key mappings for expanding snippets
      vim.api.nvim_set_keymap(
        "i",
        "<C-k>",
        "<cmd>lua require'luasnip'.expand_or_jump()<CR>",
        { silent = true, noremap = true }
      )
      vim.api.nvim_set_keymap("s", "<C-k>", "<cmd>lua require'luasnip'.jump(1)<CR>", { silent = true, noremap = true })
    end,
  },

  -- nvim-cmp installation with configuration
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require "cmp"
      require("luasnip").filetype_extend("javascriptreact", { "html" })
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        }),
      }
    end,
  },

  {
    "hrsh7th/cmp-path",
    config = function()
      local cmp = require "cmp"

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
}
