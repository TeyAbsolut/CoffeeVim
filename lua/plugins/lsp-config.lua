return {
    "neovim/nvim-lspconfig",
    config = function()
        -- Lua configuration
        vim.lsp.config("lua_ls", {
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath("config")
                        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
                    then
                        return
                    end
                end
                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most
                        -- likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                        -- Tell the language server how to find Lua modules same way as Neovim
                        path = {
                            "lua/?.lua",
                            "lua/?/init.lua",
                        },
                    },

                    diagnostics = {
                        globals = {
                            "vim",
                        },
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                        },
                    },
                })
            end,
            settings = {
                Lua = {},
            },
        })

        local lspconfig = require("lspconfig")
        local home = os.getenv("HOME")

        lspconfig.ts_ls.setup({
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = home ..
                            "/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
                        languages = { "vue" },
                    },
                },
            },
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        })

        local servers = { "css_variables", "cssmodules_ls", "cssls", "angularls", "svelte", "vue_ls", "html", "htmx" }

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({})
        end

        local function get_python_path()
            local cwd = vim.fn.getcwd()

            -- Check common virtual environment locations
            local venv_paths = {
                cwd .. '/venv/bin/python',
                cwd .. '/.venv/bin/python',
                cwd .. '/env/bin/python',
                cwd .. '/.env/bin/python',
            }

            for _, path in ipairs(venv_paths) do
                if vim.fn.executable(path) == 1 then
                    return path
                end
            end

            -- Check if VIRTUAL_ENV is set
            local virtual_env = vim.fn.getenv('VIRTUAL_ENV')
            if virtual_env and virtual_env ~= vim.NIL then
                local venv_python = virtual_env .. '/bin/python'
                if vim.fn.executable(venv_python) == 1 then
                    return venv_python
                end
            end

            -- Check conda environment
            local conda_env = vim.fn.getenv('CONDA_DEFAULT_ENV')
            if conda_env and conda_env ~= vim.NIL then
                local conda_python = vim.fn.system('which python'):gsub('\n', '')
                if vim.fn.executable(conda_python) == 1 then
                    return conda_python
                end
            end

            -- Fallback to system python
            return 'python'
        end

        -- Python LSP Server configuration
        lspconfig.pylsp.setup({
            settings = {
                pylsp = {
                    plugins = {
                        -- Disable default plugins that conflict with our choices
                        autopep8 = { enabled = false },
                        yapf = { enabled = false },
                        pylint = { enabled = false },
                        pycodestyle = { enabled = false },
                        mccabe = { enabled = false },
                        pyflakes = { enabled = false },

                        -- Enable flake8
                        flake8 = {
                            enabled = true,
                            maxLineLength = 88,          -- Match black's line length
                            ignore = { 'E203', 'W503' }, -- Ignore conflicts with black
                        },

                        -- Enable black formatting
                        black = {
                            enabled = true,
                            line_length = 88,
                        },

                        -- Enable isort for import sorting
                        isort = {
                            enabled = true,
                            profile = 'black', -- Make isort compatible with black
                        },

                        -- Keep some useful default plugins
                        jedi_completion = { enabled = true },
                        jedi_hover = { enabled = true },
                        jedi_references = { enabled = true },
                        jedi_signature_help = { enabled = true },
                        jedi_symbols = { enabled = true },
                    },
                },
            },
            before_init = function(_, config)
                -- Set the Python interpreter for pylsp to use
                local python_path = get_python_path()
                config.settings.pylsp.plugins.jedi = {
                    environment = python_path,
                }
            end,
        })
    end,
}
