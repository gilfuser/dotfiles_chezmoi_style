local function map(m, k, v, d)
	vim.keymap.set(m, k, v, d)
end

map("n", "*", "*N", { silent = true, desc = " Fix * Keep the cursor position, dont move to next match" })

map("n", "n", "nzz", { silent = true, desc = "fix n. Keeping cursor in center" })
map("n", "N", "Nzz", { silent = true, desc = "Fix N. Keeping cursor in center" })

map("n", "<leader>w", "<CMD>update<CR>", { silent = true, desc = "Quickly save the current buffer or all buffers" })
map("n", "<leader>W", "<CMD>wall<CR>", { silent = true, desc = "Quickly save the current buffer or all buffers" })
-- vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { silent = true, desc = '[S]earch [R]esume' })

-- TODO: keep cursor position when is O. Problem: the line number changes
map(
	"n",
	"<leader>o",
	'<CMD>let sp = getpos(".")<CR>o<ESC><CMD>call setpos(".",sp)<CR>',
	{ silent = true, desc = "insert line below. Keeping cursor in position" }
)
map("n", "<leader>O", "O<ESC>j", { silent = true, desc = "insert line above. Keeping cursor in line" })
map(
	"v",
	"<leader>o",
	'<ESC><CMD>let sp = getpos(".")<CR>o<ESC><CMD>call setpos(".",sp)<CR>',
	{ silent = true, desc = "insert line below. Keeping cursor in position" }
)
map("v", "<leader>O", "<ESC>O<ESC>j", { silent = true, desc = "insert line above. Keeping cursor in line" })
map(
	"i",
	"<leader>o",
	'<ESC>l<CMD>let sp = getpos(".")<CR>o<ESC><CMD>call setpos(".",sp)<CR>i',
	{ silent = true, desc = "insert line below. Keeping cursor in position" }
)
map("i", "<leader>O", "<ESC>O<ESC>j", { silent = true, desc = "insert line above. Keeping cursor in line" })

map("n", "<leader>[", "<CMD>bp<CR>", { silent = true, desc = "move to previous buffer" })
map("n", "<leader>]", "<CMD>bn<CR>", { silent = true, desc = "move to next buffer" })

-- Copying the vscode behaviour of making tab splits
map("n", "<C-\\>", "<CMD>vsplit<CR>", { silent = true, desc = "make vertical split" })
map("n", "<A-\\>", "<CMD>split<CR>", { silent = true, desc = "make horizontal split" })

-- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
map("n", "<A-j>", "<CMD>move .+1<CR>", { silent = true, desc = "move line down" })
map("n", "<A-k>", "<CMD>move .-2<CR>", { silent = true, desc = "move line up" })
map("x", "<A-j>", ":move '>+1<CR>gv=gv", { silent = true, desc = "move line down" })
map("x", "<A-k>", ":move '<-2<CR>gv=gv", { silent = true, desc = "move line up" })

-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
map(
	"o",
	"A",
	":<C-U>normal! mzggVG<CR>`z",
	{ silent = true, desc = "Use operator pending mode to visually select the whole buffer" }
)
map(
	"x",
	"A",
	":<C-U>normal! ggVG<CR>",
	{ silent = true, desc = "Use operator pending mode to visually select the whole buffer" }
)

map("n", "<C-h>", "gT", { noremap = true, silent = true, desc = "move to tab: Left" })
map("n", "<C-l>", "gt", { noremap = true, silent = true, desc = "move to tab: Right" })

-- easyest moving inside splits
map("n", "<A-H>", "<c-w>h", { noremap = true, silent = true, desc = "move to split: Left" })
map("n", "<A-J>", "<c-w>k", { noremap = true, silent = true, desc = "move to split: Up" })

map("n", "<A-L>", "<c-w>l", { noremap = true, silent = true, desc = "move to split: Right" })

-- substitute a little bit faster
-- map({ "n", "i", "v" }, "<leader>fi", "<ESC>:,$s/", { noremap = true, silent = true, desc = "find and substitute faster" })
-- map({ "n", "i", "v" }, "<leader>fl", "<Esc>:s/", { noremap = true, silent = true, desc = "subsitute faster Linewise" })
-- Select word faster
map({ "n", "i" }, "<leader>w", "<Esc>viw", { noremap = true, silent = true, desc = "select [w]ord" })
map("v", "<leader>w", "iw", { noremap = true, silent = true, desc = "select word" })
map("n", "<leader>W", "viW", { noremap = true, silent = true, desc = "select word(s) in spaces" })
map("v", "<leader>W", "iW", { noremap = true, silent = true, desc = "select word(s) inside spaces" })
-- ... and change it
map("n", "<leader>C", '"_ciw', { noremap = true, silent = true, desc = "change word" })
-- to select in inside "" c <> {} ()
map({ "n", "i" }, "<leader>'", "<Esc>vi'", { noremap = true, silent = true, desc = "select inside single quotes" })
map("n", "<localleader>'", "va'", { noremap = true, silent = true, desc = "select all including single quotes" })
map({ "n", "i" }, '<leader>"', '<Esc>vi"', { noremap = true, silent = true, desc = "select inside double quotes" })
map({ "n", "i" }, "<leader>{", "<Esc>vi{", { noremap = true, silent = true, desc = "select inside {} []" })
map("n", "<localleader>{", "va{", { noremap = true, silent = true, desc = "select including {} []" })
map({ "n", "i" }, "<leader>[", "<Esc>vi[", { noremap = true, silent = true, desc = "select inside []" })
map("n", "<localleader>[", "va[", { noremap = true, silent = true, desc = "select including []" })
map({ "n", "i" }, "<leader>(", "<Esc>vi(", { noremap = true, silent = true, desc = "select inside parenthesis" })
map("n", "<localleader>(", "va(", { noremap = true, silent = true, desc = "select including parenthesis" })
map(
	{ "n", "i" },
	"<leader><",
	"<Esc>vi<",
	{ noremap = true, silent = true, desc = "select inside less-then greater-then" }
)
map("n", "<localleader><", "va<", { noremap = true, silent = true, desc = "select including less-then greater-then" })
-- to change in inside "" [] <> {} ()
map("i", "<localleader>'", "<Esc>va'c", { noremap = true, silent = true, desc = "change including single quotes" })
map({ "n", "i" }, '<A-">', '<ESC>"_ci"', { noremap = true, silent = true, desc = "change inside double quotes" })
map(
	{ "n", "i" },
	'<localleader>"',
	'<Esc>va"c',
	{ noremap = true, silent = true, desc = "change including double quotes" }
)
map({ "n", "i" }, "<A-0>", '<Esc>"_ci{', { noremap = true, silent = true, desc = "change inside {}" })
map(
	{ "n", "i" },
	"<leader><A-0>",
	'<Esc>"_ca{',
	{ noremap = true, silent = true, desc = "change including {}" }
)
map({ "n", "i" }, "<A-9>", '<Esc>"_ci[', { noremap = true, silent = true, desc = "change inside []" })
map({ "n", "i" }, "<leader><A-9>", '<Esc>"_ca[', { noremap = true, silent = true, desc = "change including []" })
map({ "n", "i" }, "<A-8>", '<Esc>"_ci(', { noremap = true, silent = true, desc = "change inside parenthesis" })
map({ "n", "i" }, "<leader><A-8>", '"_ca)', { noremap = true, silent = true, desc = "change including parenthesis" })
map({ "n", "i" }, "<A-<>", "<Esc>ci<", { noremap = true, silent = true, desc = "change inside less-greater-then" })
map({ "n", "i" }, "<leader>>", '<Esc>"_ca>',
	{ noremap = true, silent = true, desc = "change including <>" }
)

map({ "i", "n", "x" }, "<leader>l", "<Esc>g_v^",
	{ noremap = true, silent = true, desc = "select whole line from last to first non-empty char" }
)

map("i", "<c-k>", "<c-o>gk", { silent = true, desc = "move up in insert mode" })
-- map("i", "<C-h>", "<ESC>hi", { noremap = true })
map("i", "<C-l>", "<C-o>l", { silent = true, desc = "move right in insert mode" })
map("i", "<C-j>", "<C-o>gj", { silent = true, desc = "move down in inster mode" })

map("n", "<A-l>", "vxp", { silent = true, desc = "move character right" })
map("n", "<A-h>", "vxhhp", { silent = true, desc = "move character left" })
map("i", "<A-l>", "<ESC>xpi", { silent = true, desc = "move character right" })
map("i", "<A-h>", "<ESC>xhhpi", { silent = true, desc = "move character left" })
map("x", "<A-l>", "xpv", { silent = true, desc = "move character right" })
map("x", "<A-h>", "xhhpv", { silent = true, desc = "move character left" })

map("n", "<A-#>", "g;", { silent = true, desc = "go forward to next edit" })
map("n", "<A-'>", "g,", { silent = true, desc = "go backwards to previous edit" })

map({ "n", "v" }, "<leader><A-n>", ":noh<CR>", { silent = true, desc = "turn search highlight off" })

-- scroll up + get rid of acidental Ctrl + z
map("i", "<C-z>", "<ESC>l<C-e>i", { silent = true })
map({ "n", "v" }, "<C-z>", "<C-e>", { silent = true })

-- thePrimeagen Stuff
map("n", "J", "mzJ`z", { silent = true, desc = "append the line below with the current line" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("x", "<leader>p", '"_dP')
map({ "n", "v" }, "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')
map({ "n", "v" }, "<leader>d", '"_d')
map({ "n", "v" }, "<leader>c", '"_c')
map("n", "Q", "<nop>")
-- map("n", "<leader>f", function() vim.lsp.buf.format() end) -- depends on tmux
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
	{ desc = "replace all occurences of the word you are on" }
)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "make this file executable" })

--  quickfix navigation
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<c-p>", "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
map("n", "<c-s>", ":SCNvimExt fzf-sc.fuzz<CR>", { silent = true })
map("n", "<leader>fb", ":Telescope file_browser<CR>", { noremap = true })
map("n", "<leader>cm", ":Telescope commands<CR>", { noremap = true })
map("n", "<leader>cl", ":Telescope colorscheme<CR>", { noremap = true })
map("n", "<leader>km", ":Telescope keymaps<CR>", { noremap = true })
map("n", "<leader>ts", ":Telescope treesitter<CR>", { noremap = true })

-- /////////////////// Hop //////////////////////// --

-- place this in one of your configuration file(s)
require("hop").setup({})
local hop = require("hop")
local directions = require("hop.hint").HintDirection

map("", "<M-f>", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true, desc = "hop [f]ind character forwards the current line" })
map("", "<M-F>", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true, desc = "hop [F]ind character backwards in the current line" })
map("", "<M-t>", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true, desc = "hop go forwards next [t]o the character in the current line" })
map("", "<M-T>", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true, desc = "hop go backwards next [T]o character in current line" })

map("", "<M-w>", "<CMD>HopWordCurrentLine<CR>", { desc = 'hop hint [w]ords in current line' })
map("n", "<M-W>", "<CMD>HopWord<CR>", { desc = 'hop hint all [W]ords in current buffer' })
map("n", "<M-/>", "<CMD>HopPattern<CR>", { desc = 'HopPattern is like neovim search "/"' })

