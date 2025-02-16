return {
  { "nvchad/volt", lazy = true },
  {
    "nvchad/minty",
    lazy = true,
    config = function()
      require("minty.huefy").open()
      require("minty.shades").open()

      -- For border or without border
      require("minty.huefy").open { border = true }
      -- add border=false for flat look on shades window
    end,
  },
}
