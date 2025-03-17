local home = os.getenv('HOME')
local jdtls = require('jdtls')
local root_markers = {'gradlew', 'mvnw', '.git', 'pom.xml', 'build.gradle'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = home .. "/.local/share/nvim/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Create workspace folder if it doesn't exist
os.execute("mkdir -p " .. workspace_folder)

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration', home .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
        '-data', workspace_folder,
    },
    root_dir = root_dir,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
                favoriteStaticMembers = {},
                filteredTypes = {
                    -- "com.sun.*",
                    -- "io.micrometer.shaded.*",
                    -- "java.awt.*",
                    -- "jdk.*",
                    -- "sun.*",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                useBlocks = true,
            },
        },
    },
    init_options = {
        bundles = {},
        extendedClientCapabilities = {
            progressReportProvider = true,
            classFileContentsSupport = true
        }
    },
    on_attach = function(client, bufnr)
        -- Your on_attach function here
        vim.bo[bufnr].shiftwidth = 4
        vim.bo[bufnr].tabstop = 4
        
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities()
}

-- Start the server
jdtls.start_or_attach(config)

