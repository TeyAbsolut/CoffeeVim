return {
	"saghen/blink.cmp",
	dependencies = { "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets", "onsails/lspkind.nvim" },
    version = "1.*",
	opts = {
		keymap = {
			preset = "default",
			["<C-space>"] = { "show", "show_documentation" }, -- Trigger completion and show docs
			["<C-e>"] = { "hide" }, -- Close completion menu
			["<CR>"] = { "accept", "fallback" }, -- Accept completion or insert newline
			["<Tab>"] = { "accept", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" }, -- Navigate backward
			["<C-b>"] = { "scroll_documentation_up" }, -- Scroll docs up
			["<C-f>"] = { "scroll_documentation_down" }, -- Scroll docs down
		},
		appearance = {
			highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
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
						},
					},
				},
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		fuzzy = {
            implementation = "lua",
            sorts = { "score" },
        },
	},
	opts_extend = { "sources.default" },
}
