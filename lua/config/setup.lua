-- General settings
vim.wo.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Diagnostic configuration for inline warnings and errors
vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- Symbol for virtual text
    source = true, -- Show source of diagnostic
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
  update_in_insert = false, -- Don't update diagnostics while typing
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
require('lualine').setup({
    options = { theme = 'auto' },
})

-- TreeSitter Setup
require('nvim-treesitter.configs').setup({
    ensure_installed = { 'java', 'lua' },
    sync_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    modules = {},
    ignore_install = {},
    auto_install = true,
})

-- Mason Setup
require('mason').setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "jdtls" },
    automatic_enable = true,
})

-- Autocompletion setup
local cmp = require("blink.cmp")
cmp.setup({
    keymap = {
        preset = 'default',
        ['<C-space>'] = { 'show', 'show_documentation' }, -- Trigger completion and show docs
        ['<C-e>'] = { 'hide' }, -- Close completion menu
        ['<CR>'] = { 'accept', 'fallback' }, -- Accept completion or insert newline
        ['<Tab>'] = { 'accept', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' }, -- Navigate backward
        ['<C-b>'] = { 'scroll_documentation_up' }, -- Scroll docs up
        ['<C-f>'] = { 'scroll_documentation_down' }, -- Scroll docs down
    },
    appearance = {
        highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
    },
    cmdline = { enabled = false },
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        ghost_text = { enabled = true },
        menu = {
            draw = {
                components = {
                    kind_icon = {
                        text = function(ctx)
                            local icon = ctx.kind_icon
                            if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                if dev_icon then
                                    icon = dev_icon
                                end
                            else
                                icon = require("lspkind").symbolic(ctx.kind, {
                                    mode = "symbol",
                                })
                            end

                            return icon .. ctx.icon_gap
                        end,

                        -- Optionally, use the highlight groups from nvim-web-devicons
                        -- You can also add the same function for `kind.highlight` if you want to
                        -- keep the highlight groups in sync with the icons.
                        highlight = function(ctx)
                            local hl = ctx.kind_hl
                            if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                if dev_icon then
                                    hl = dev_hl
                                end
                            end
                            return hl
                        end,
                    }
                }
            }
        }
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
})

-- Noice Setup 
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
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

-- DAP Setup
require('config.dap')
