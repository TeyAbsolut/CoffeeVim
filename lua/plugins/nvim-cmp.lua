return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/vim-vsnip',
        },
        config = function()
            local cmp = require('cmp')

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn['vsnip#anonymous'](args.body) -- For vsnip integration
                    end,
                },
                mapping = {
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Enter
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif vim.fn['vsnip#available'](1) == 1 then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.fn['vsnip#jumpable'](-1) == 1 then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-prev)', true, true, true),
                                '')
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' }, -- LSP source
                    { name = 'vsnip' },    -- Vsnip source
                    { name = 'buffer' },   -- Buffer source
                    { name = 'path' },     -- Filesystem paths
                }),
                formatting = {
                    format = function(entry, vim_item)
                        -- Use nvim-web-devicons for kind icons
                        local devicons = require('nvim-web-devicons')
                        local icon, _ = devicons.get_icon_by_filetype(vim_item.kind:lower(), { default = true })
                        if not icon then
                            icon = '' -- Fallback icon
                        end
                        vim_item.kind = string.format('%s %s', icon, vim_item.kind)
                        vim_item.menu = ({
                            nvim_lsp = '[LSP]',
                            vsnip = '[Snip]',
                            buffer = '[Buf]',
                            path = '[Path]',
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })

            -- Enable vsnip for specific filetypes
            vim.g.vsnip_filetypes = {
                javascript = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
                typescript = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
                java = { 'java' },
                lua = { 'lua' },
            }
        end,
    },
}
