return {
    { 'mason-org/mason.nvim', opts = {}, lazy = false },
    { 'williamboman/mason-lspconfig.nvim',
        opts = {
            ensure_installed = {
                "jdtls",
                "lua-language-server",
                "stylua",
                "google-java-format",
                "typescript-language-server",
                "angular-language-server",
                "vue-language-server",
                "svelte-language-server",
            },
	        automatic_enable = true,
        }
    },
}
