local home = os.getenv('HOME')
local jdtls_path = home .. '/.local/share/nvim/mason/packages/jdtls'
local lombok_path = jdtls_path .. '/lombok.jar'
local workspace_path = home .. '/.cache/nvim/jdtls/workspace'
local java_debug_path = vim.fn.expand("~/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-0.53.1.jar")

local config = {
  cmd = {
    'java',

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx2g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. lombok_path,

    '-jar', jdtls_path .. '/plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar',
    
    '-configuration', jdtls_path .. '/config_linux',

    '-data', workspace_path,
  },

  root_dir = vim.fs.root(0, {"pom.xml", ".git", "mvnw", "gradlew"}),

  settings = {
    java = {
    }
  },

  init_options = {
    bundles = { java_debug_path }
  },
}

-- Test runner setup with neotest-java
local neotest = require("neotest")
neotest.setup({
    adapters = {
        require("neotest-java")({
            junit_jar = nil,
            incremental_build = true
        }),
    },
})

require('jdtls').start_or_attach(config)
