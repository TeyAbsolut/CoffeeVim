return {
    { 'mason-org/mason.nvim', opts = {}, lazy = false },
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {
            ensure_installed = {
                "jdtls",
                "lua-language-server",
                "stylua",
                "prettier",
                "google-java-format",
                "typescript-language-server",
                "angular-language-server",
                "vue-language-server",
                "svelte-language-server",
                "css-lsp",
                "css-variables-language-server",
                "cssmodules-language-server",
                "python-lsp-server",
                "black",
                "flake8",
                "isort",
                "debugpy",
                "html",
                "htmx",
            },
            automatic_enable = true,
        }
    },
}
