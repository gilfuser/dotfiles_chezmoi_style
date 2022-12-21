--[[ require('leap').set_default_keymaps(true)
vim.keymap.set('n', '<leader-s>', '<Plug>(leap-forward)', {})
vim.keymap.set('n', '<leader-S>', '<Plug>(leap-backward)', {})
vim.keymap.set('i', '<leader-s>', '<Plug>(leap-forward)', {})
vim.keymap.set('i', '<leader-S>', '<Plug>(leap-backward)', {})
vim.keymap.set('v', '<leader-s>', '<Plug>(leap-forward)', {})
vim.keymap.set('v', '<leader-S>', '<Plug>(leap-backward)', {}) ]]
require("hop").setup({})
vim.api.nvim_set_keymap(
	"",
	"<C-f>",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>",
	{}
)
vim.api.nvim_set_keymap(
	"",
	"<C-F>",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>",
	{}
)
vim.api.nvim_set_keymap(
	"",
	"<A-t>",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })<cr>",
	{}
)
vim.api.nvim_set_keymap(
	"",
	"<A-T>",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })<cr>",
	{}
)
vim.api.nvim_set_keymap("n", "<A-w>", ":HopWord<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-f>", ":HopPattern<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":HopLine<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-L>", ":HopLineStart<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-A>", ":HopAnyware<cr>", { silent = true })
