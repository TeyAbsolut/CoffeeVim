return {
	{ "goolord/alpha-nvim" },
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
            require('onedark').setup {
                style = 'darker'
            }
			require("onedark").load()
		end,
	},
	{ "folke/which-key.nvim", lazy = false },
	{ "lewis6991/gitsigns.nvim", lazy = false },
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = { theme = "auto" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "java", "lua", "vue", "svelte", "angular", "javascript", "typescript" },
				sync_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				modules = {},
				ignore_install = {},
				auto_install = true,
			})
		end,
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "nvim-tree/nvim-tree.lua", version = "*", opts = {}, lazy = false },
	{
		"romgrk/barbar.nvim",
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = true,
			clickable = true,
			focus_on_close = "left",
			sidebar_filetypes = {
				NvimTree = true,
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim", "jonarrien/telescope-cmdline.nvim" },
		config = function()
			local telescope = require("telescope")
			telescope.setup({})
			telescope.load_extension("cmdline")
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "rcarriga/nvim-notify" },
		opts = {
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
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({ scope = { highlight = highlight } })

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
}
