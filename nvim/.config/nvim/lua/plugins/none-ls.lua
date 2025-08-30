return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require "null-ls"

    null_ls.setup {
      sources = {
        null_ls.builtins.diagnostics.codespell,
        null_ls.builtins.diagnostics.commitlint,
        null_ls.builtins.diagnostics.gitlint,
        -- Configure golangci_lint with proper working directory detection
        null_ls.builtins.diagnostics.golangci_lint.with({
          condition = function(utils)
            -- Only run if we're in a Go project with go.mod
            return utils.root_has_file("go.mod")
          end,
          cwd = function(params)
            -- Set working directory to the Go module root
            return vim.fs.dirname(vim.fs.find("go.mod", { upward = true, path = params.bufname })[1])
          end,
        }),
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.diagnostics.erb_lint,
        -- null_ls.builtins.diagnostics.phpcs,
        -- Configure goimports with proper working directory
        null_ls.builtins.formatting.goimports.with({
          condition = function(utils)
            return utils.root_has_file("go.mod")
          end,
          cwd = function(params)
            return vim.fs.dirname(vim.fs.find("go.mod", { upward = true, path = params.bufname })[1])
          end,
        }),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.rubocop,
        null_ls.builtins.formatting.phpcsfixer,

        -- for python format
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
      },
      -- Configure root directory detection
      root_dir = function(fname)
        return require("null-ls.utils").root_pattern(
          "go.work",
          "go.mod",
          ".git",
          "package.json",
          "Gemfile",
          "composer.json"
        )(fname)
      end,
    }

    -- keybindings
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
