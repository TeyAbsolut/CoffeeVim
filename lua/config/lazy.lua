-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
        { 'nvim-tree/nvim-web-devicons', lazy = true },
        { 'lewis6991/gitsigns.nvim', lazy = false },
        { 'nvim-treesitter/nvim-treesitter' },
        { 'nvim-lualine/lualine.nvim' },
        { 'neovim/nvim-lspconfig' },
        { 'mason-org/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
  	    { 'L3MON4D3/LuaSnip' },
  	    { 'saadparwaiz1/cmp_luasnip' },
        { 'mfussenegger/nvim-dap' },
	    { 'rcarriga/nvim-dap-ui', dependencies = { "mfussenegger/nvim-dap" } },
        { 'mfussenegger/nvim-jdtls' },
        { "nvim-neotest/neotest", dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter" } },
        { "rcasia/neotest-java", ft = "java", dependencies = { "mfussenegger/nvim-jdtls", "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text" } },
        { 'folke/which-key.nvim', lazy = false },
        { 'nvim-tree/nvim-tree.lua', version = '*', lazy = false },
        { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
        { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim', 'jonarrien/telescope-cmdline.nvim' } },
        { 'romgrk/barbar.nvim' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
