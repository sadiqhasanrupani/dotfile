local home = os.getenv "HOME"
-- local workspace_folder = home .. "/.local/share/nvim/mason/packages/jdtls/bin"
-- local config_folder = home .. "/.local/share/nvim/mason/packages/jdtls/config/"

return {
  "mfussenegger/nvim-jdtls",
  config = function()
    local status, jdtls = pcall(require, "jdtls")
    if not status then
      return
    end
    local extendedClientCapabilities = jdtls.extendedClientCapabilities

    require("jdtls").start_or_attach {
      cmd = { vim.fn.expand "~/.local/share/nvim/mason/packages/jdtls/bin/jdtls" },
      home .. "/.local/share/nvim/mason/packages/jdtls/config/",
      "-javaagent" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
      root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
      settings = {
        java = {
          signatureHelp = { enabled = true },
          extendedClientCapabilities = extendedClientCapabilities,
        },
      },
    }
  end,
}
