local dap = require("dap")
local neotest = require("neotest")
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>', { desc = 'Open file [E]xplorer' })
vim.keymap.set('n', '<leader>qs', ':wqa<cr>', { desc = '[Q]uit and [S]ave' })
vim.keymap.set('n', '<leader>qw', ':qa!<cr>', { desc = '[Q]uit [W]ithout saving' })

vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Find references" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue debugging" })
vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>dt", function() require("dapui").toggle() end, { desc = "Toggle debugger UI" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show diagnostic details" })
vim.keymap.set("n", "<leader>tt", function() neotest.run.run() end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run all tests in file" })
vim.keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Toggle test summary" })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope cmdline<cr>', { desc = 'Telescope command line' })

vim.keymap.set('n', '<C-m>o', '<cmd>Maven<CR>', { desc = 'Open Maven' })
vim.keymap.set('n', '<C-m>e', '<cmd>MavenExec<CR>', { desc = 'Execution  maven command' })
vim.keymap.set('n', '<C-m>i', '<cmd>MavenInit<CR>', { desc = 'Initialize maven project' })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<C-Left>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<C-Right>', '<Cmd>BufferNext<CR>', opts)

-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

map('n', '<CS-F>', "<Cmd>lua vim.lsp.buf.format()<CR>", opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)

vim.keymap.set('n', "<leader>mi", "<cmd>MoltenInit<CR>")
vim.keymap.set('n', "<leader>mc", "<Cmd>MoltenEvaluateOperator<CR>")
vim.keymap.set('n', "<leader>mr", "<Cmd>MoltenReevaluateCell<CR>")
vim.keymap.set('n', "<leader>mn", "<Cmd>MoltenNext<CR>")
vim.keymap.set('n', "<leader>mp", "<Cmd>MoltenPrev<CR>")
vim.keymap.set('n', "<leader>mo", "<Cmd>MoltenOpenInBrowser<CR>")
vim.keymap.set('n', "<leader>mv", "<Cmd>MoltenEvaluateVisual<CR>")
vim.keymap.set('n', "<leader>ml", "<Cmd>MoltenEvaluateLine<CR>")
vim.keymap.set('n', "<leader>md", "<Cmd>MoltenDelete<CR>")
