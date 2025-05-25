return {
    { 'mason-org/mason.nvim', opts = {}, lazy = false },
    { 'williamboman/mason-lspconfig.nvim',
        opts = {
            ensure_installed = { "jdtls" },
	        automatic_enable = true,
        }
    },
}
