return {
    -- Molten.nvim plugin for Jupyter kernel integration
    {
        "benlubas/molten-nvim",
        lazy = false,
        version = "^1.0.0", -- Pin to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- Molten configuration options
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = false -- Prevent auto-opening output window
            vim.g.molten_wrap_output = true
            vim.g.molten_virt_text_output = true
            vim.g.molten_virt_lines_off_by_1 = true
        end,
    },
    -- image.nvim for rendering images in Neovim
    {
        "3rd/image.nvim",
        opts = {
            backend = "kitty", -- Use Kitty backend for image rendering
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge, -- Prevent resizing issues
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
    },
}
