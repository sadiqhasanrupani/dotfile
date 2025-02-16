return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        blade = { "blade-formatter" },
      },
    }
  end,
}
