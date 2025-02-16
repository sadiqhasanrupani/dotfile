return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")

    notify.setup({
      stages = "slide",
      fps = 30,
      position = "bottom_right",
      timeout = 1000,
    })

    notify("Welcome Sadiqhasan! Happy Coding!")
  end,
}
