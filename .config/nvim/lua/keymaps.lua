--
-- [[ keymaps ]]
--
--  see `:help vim.keymap.set()`

-- clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- diagnostic keymaps
-- view errors/warnings
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'open diagnostic' })

-- exit terminal mode gracefully
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'quick exit terminal mode' })

-- disable arrow keys
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<left>', 	'<Nop>', opts)
vim.keymap.set('n', '<right>',	'<Nop>', opts)
vim.keymap.set('n', '<up>',   	'<Nop>', opts)
vim.keymap.set('n', '<down>', 	'<Nop>', opts)

-- keybinds for splits
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'shift focus to left split' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'shift focus to right split' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'shift focus to lower split' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'shift focus to the upper split' })

-- highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'highlight area when yanking text',
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({timeout = 150})
  end,
})
