return {
  "https://github.com/RomanVolkov/go.get.nvim",
  keys = function()
    return {
      {
        "<leader>gog",
        function()
          require("telescope").extensions.go_get.packages_search()
        end,
        desc = "[G]o [G]et packages",
      },
    }
  end,
}
