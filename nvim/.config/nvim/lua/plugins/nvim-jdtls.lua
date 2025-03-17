return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    local status, jdtls = pcall(require, "jdtls")
    if not status then
      return
    end

    local home = os.getenv("HOME")
    local root_markers = { "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }
    local root_dir = require("jdtls.setup").find_root(root_markers)
    local workspace_folder = home .. "/.local/share/nvim/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

    -- Create workspace folder if it doesn't exist
    vim.fn.mkdir(workspace_folder, "p")

    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob(
          home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
        ),
        "-configuration",
        home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
        "-data",
        workspace_folder,
      },
      root_dir = root_dir,
      settings = {
        java = {
          signatureHelp = { enabled = true },
          configuration = { updateBuildConfiguration = "interactive" },
          maven = { downloadSources = true },
          implementationsCodeLens = { enabled = true },
          referencesCodeLens = { enabled = true },
          references = { includeDecompiledSources = true },
          format = {
            enabled = true,
            settings = {
              url = home .. "/.local/share/nvim/mason/packages/jdtls/eclipse-java-google-style.xml",
              profile = "GoogleStyle",
            },
          },
        },
        signatureHelp = { enabled = true },
        completion = { favoriteStaticMembers = {}, filteredTypes = {} },
        sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
        codeGeneration = {
          toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
          useBlocks = true,
        },
      },
      init_options = {
        bundles = {},
        extendedClientCapabilities = { progressReportProvider = true, classFileContentsSupport = true },
      },
      on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)

        -- Set some formatting options
        vim.bo[bufnr].shiftwidth = 4
        vim.bo[bufnr].tabstop = 4
      end,
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    }

    -- Start the server
    jdtls.start_or_attach(config)
  end,
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },
}
