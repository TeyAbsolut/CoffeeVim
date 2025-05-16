-- General settings
vim.wo.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Diagnostic configuration for inline warnings and errors
vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- Symbol for virtual text
    source = "always", -- Show source of diagnostic
    format = function(diagnostic)
      return string.format("%s: %s", diagnostic.source, diagnostic.message)
    end,
  },
  signs = {
    active = true,
    text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = "󰋼 ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
    texthl = {
            [vim.diagnostic.severity.ERROR] = "Error",
            [vim.diagnostic.severity.WARN] = "Error",
            [vim.diagnostic.severity.HINT] = "Hint",
            [vim.diagnostic.severity.INFO] = "Info",
    },
    numhl = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
    },
  },
  update_in_insert = true, -- Don't update diagnostics while typing
  severity_sort = true, -- Sort by severity (errors first)
})

-- Theme Setup
require('catppuccin').setup({
    flavour = 'mocha'
})
vim.cmd.colorscheme 'catppuccin'

-- NvimTree Setup
require('nvim-tree').setup({})

-- LuaLine Setup
require('lualine').setup({})

-- TreeSitter Setup
require('nvim-treesitter.configs').setup({
    ensure_installed = { 'java', 'lua' },
    sync_install = true,
    highlight = { enable = true },
    indent = { enable = true },
})

-- Mason Setup
require('mason').setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "jdtls" },
})

-- Java LSP Setup
require('config.java.lsp')

-- Java DAP Setup
require('config.java.dap')

-- Autocompletion setup
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
})

-- Telescope Setup
local telescope = require('telescope')
telescope.setup({})
telescope.load_extension('cmdline')

-- Barbar Setup
vim.g.barbar_auto_setup = false

require'barbar'.setup {
    animation = true,
    clickable = true,
    focus_on_close = 'left',
    sidebar_filetypes = {
        NvimTree = true,
    }
}
