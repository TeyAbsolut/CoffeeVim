return {
	{ "goolord/alpha-nvim" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = { flavour = "mocha" },
		config = function()
			vim.cmd.colorscheme("catppuccin")
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
				ensure_installed = { "java", "lua" },
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
}
