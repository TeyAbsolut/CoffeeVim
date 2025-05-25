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
                plugins = { -- I think this was my breakthrough that made it work
                    {
                        name = "@vue/typescript-plugin",
                        location = home .. "/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
                        languages = { "vue" },
                    },
                },
            },
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        })

        local servers = { "css_variables", "cssmodules_ls", "cssls", "angularls", "svelte", "vue_ls" }

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({})
        end
    end,
}
