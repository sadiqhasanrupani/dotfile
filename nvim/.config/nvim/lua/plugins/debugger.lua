return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- Adds UI to nvim-dap
      "nvim-neotest/nvim-nio", -- Add nvim-nio as a dependency
      "leoluz/nvim-dap-go", -- Add nvim-dap-go as a dependency
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dap-go").setup()

      -- Setup dap-ui
      dapui.setup()

      -- Automatically open dap-ui when debugging starts
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- Automatically close dap-ui when the session terminates or exits
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Keybindings for dap
      vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue Debugging" })
      vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<Leader>du", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
      vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run Last" })
    end,
  },
}

