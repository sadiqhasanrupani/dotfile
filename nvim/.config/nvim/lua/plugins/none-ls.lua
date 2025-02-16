return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require "null-ls"

    null_ls.setup {
      sources = {
        null_ls.builtins.diagnostics.codespell,
        null_ls.builtins.diagnostics.commitlint,
        null_ls.builtins.diagnostics.gitlint,
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.diagnostics.erb_lint,
        -- null_ls.builtins.diagnostics.phpcs,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.rubocop,
        null_ls.builtins.formatting.phpcsfixer,

        -- for python format
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
      },
    }

    -- keybindings
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
