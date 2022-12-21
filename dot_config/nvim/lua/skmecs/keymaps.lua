local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

-- Fix * (Keep the cursor position, don't move to next match)
map("n", "*", "*N")

-- Fix n and N. Keeping cursor in center
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Mimic shell movements
-- map('i', '<C-E>', '<ESC>A')
-- map('i', '<C-A>', '<ESC>I')

-- Quickly save the current buffer or all buffers
map("n", "<leader>w", "<CMD>update<CR>")
map("n", "<leader>W", "<CMD>wall<CR>")

-- Quit neovim
map("n", "<C-Q>", "<CMD>q<CR>")

-- leader-o/O inserts blank line below/above
-- without leaving cursor position (when new line is below)
-- TODO: do the same when is above. Problem: the line number changes
map("n", "<leader>o", '<CMD>let sp = getpos(".")<CR>o<ESC><CMD>call setpos(".",sp)<CR>')
map("n", "<leader>O", "O<ESC>j")
map("v", "<leader>o", '<ESC><CMD>let sp = getpos(".")<CR>o<ESC><CMD>call setpos(".",sp)<CR>')
map("v", "<leader>O", "<ESC>O<ESC>j")
map("i", "<leader>o", '<ESC>l<CMD>let sp = getpos(".")<CR>o<ESC><CMD>call setpos(".",sp)<CR>i')
map("i", "<leader>O", "<ESC>O<ESC>j")

-- Move to the next/previous buffer
-- map('n', '<leader>[', '<CMD>bp<CR>')
-- map('n', '<leader>]', '<CMD>bn<CR>')

-- Move to last buffer
-- map('n', "''", '<CMD>b#<CR>')

-- Copying the vscode behaviour of making tab splits
map("n", "<C-\\>", "<CMD>vsplit<CR>")
map("n", "<A-\\>", "<CMD>split<CR>")

-- Move line up and down in NORMAL and VISUAL modes
-- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
map("n", "<A-j>", "<CMD>move .+1<CR>")
map("n", "<A-k>", "<CMD>move .-2<CR>")
map("x", "<A-j>", ":move '>+1<CR>gv=gv")
map("x", "<A-k>", ":move '<-2<CR>gv=gv")

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
map("o", "A", ":<C-U>normal! mzggVG<CR>`z")
map("x", "A", ":<C-U>normal! ggVG<CR>")
-- nvim tree Stuff
map("n", "<leader>n", ":NvimTreeToggle<cr>")

-- easyest moving between tabs
-- map('t', '<A-h>', '<c-\><c-n>gT', { noremap=true} )
map("i", "<C-h>", "<Esc>gT", { noremap = true })
map("i", "<C-l>", "<Esc>gt", { noremap = true })
map("v", "<C-h>", "<Esc>gT", { noremap = true })
map("v", "<C-l>", "<Esc>gt", { noremap = true })
map("n", "<C-h>", "gT", { noremap = true })
map("n", "<C-l>", "gt", { noremap = true })
-- easyest moving between splits
-- map('t', '<A-H>', '<c-\><c-n><c-w>h', { noremap=true} )
-- map('t', '<A-J>', '<c-\><c-n><c-w>k', { noremap=true} )
-- map('t', '<A-K>', '<c-\><c-n><c-w>k', { noremap=true} )
-- map('t', '<A-L>', '<c-\><c-n><c-w>l', { noremap=true} )
map("i", "<A-H>", "<Esc><c-w>h", { noremap = true })
map("i", "<A-J>", "<Esc><c-w>k", { noremap = true })
map("i", "<A-K>", "<Esc><c-w>k", { noremap = true })
map("i", "<A-L>", "<Esc><c-w>l", { noremap = true })
map("n", "<A-H>", "<c-w>h", { noremap = true })
map("n", "<A-J>", "<c-w>k", { noremap = true })
map("n", "<A-K>", "<c-w>k", { noremap = true })
map("n", "<A-L>", "<c-w>l", { noremap = true })
-- substitute a little bit faster
map("n", "<leader>/", "<Esc> :,$s/", { noremap = true })
map("i", "<leader>/", "<Esc> :,$s/", { noremap = true })
map("v", "<leader>/", "<Esc> :,$s/", { noremap = true })
-- linewise:
map("n", "<leader>(", "<Esc>:s/", { noremap = true })
map("i", "<leader>(", "<Esc>:s/", { noremap = true })
map("v", "<leader>(", "<Esc>:s/", { noremap = true })
-- Select word faster
map("n", "<leader>w", "viw", { noremap = true })
map("i", "<leader>w", "<Esc> iw", { noremap = true })
map("v", "<leader>w", "iw", { noremap = true })
map("n", "<leader>W", "viW", { noremap = true })
map("v", "<leader>W", "iW", { noremap = true })
map("i", "<leader>W", "<Esc> iW", { noremap = true })
-- ... and change it
map("n", "<A-w>", '"_ciw', { noremap = true })
map("v", "<A-w>", 'iw"_c', { noremap = true })
map("n", "<C-W>", '"_ciW', { noremap = true })
-- map("i", "<C-W>", '<Esc> "_ciW', { noremap = true })
-- map("v", "<C-W>", 'iW"_c', { noremap = true })
-- to select in between "" c <> {} ()
map("n", "<leader>'", "vi'", { noremap = true })
map("i", "<leader>'", "<Esc>vi'", { noremap = true })
map("n", "<localleader>'", "va'", { noremap = true })
map("i", "<localleader>'", "<Esc>va'c", { noremap = true })
map("n", '<leader>"', 'vi"', { noremap = true })
map("i", '<leader>"', '<Esc>vi"', { noremap = true })
map("n", '<localleader>"', 'va"', { noremap = true })
map("i", '<localleader>"', '<Esc>va"c', { noremap = true })
map("n", "<leader>{", "vi{", { noremap = true })
map("i", "<leader>{", "<Esc>vi{", { noremap = true })
map("n", "<localleader>{", "va{", { noremap = true })
map("i", "<localleader>{", "<Esc>va{c", { noremap = true })
map("n", "<leader>[", "vi[", { noremap = true })
map("i", "<leader>[", "<Esc>vi[", { noremap = true })
map("n", "<localleader>[", "va[", { noremap = true })
map("i", "<localleader>[", "<Esc>va[c", { noremap = true })
map("n", "<leader>(", "vi(", { noremap = true })
map("i", "<leader>(", "<Esc>vi(", { noremap = true })
map("n", "<localleader>(", "va(", { noremap = true })
map("i", "<localleader>(", "<Esc>va(c", { noremap = true })
map("n", "<leader><", "vi<", { noremap = true })
map("i", "<leader><", "<Esc>vi<", { noremap = true })
map("n", "<localleader><", "va<", { noremap = true })
map("i", "<localleader><", "<Esc>va<c", { noremap = true })
-- to change in between "" [] <> {} ()
map("n", '<A-">', '"_ci<', { noremap = true })
map("i", '<A-">', '<Esc>"_ci"', { noremap = true })
map("n", "<A-0>", '"_ci{', { noremap = true })
map("i", "<A-0>", '<Esc>"_ci{', { noremap = true })
map("n", "<leader><A-0>", '"_ca{', { noremap = true })
map("i", "<leader><A-0>", '<Esc>"_ca{', { noremap = true })
map("n", "<A-9>", '"_ci[', { noremap = true })
map("i", "<A-9>", '<Esc>"_ci[', { noremap = true })
map("n", "<leader><A-9>", '"_ca[', { noremap = true })
map("i", "<leader><A-9>", '<Esc>"_ca[', { noremap = true })
map("n", "<A-8>", '"_ci(', { noremap = true })
map("i", "<A-8>", '<Esc>"_ci(', { noremap = true })
map("n", "<leader><A-8>", '"_ca)', { noremap = true })
map("i", "<leader><A-8>", '<Esc>"_ca(c', { noremap = true })
map("n", "<A-<>", '"_ci<', { noremap = true })
map("i", "<A-<>", "<Esc>ci<", { noremap = true })
map("n", "<leader><A-<>", '"_ca<', { noremap = true })
map("i", "<leader><A-<>", '<Esc>"_ca<c', { noremap = true })

-- select whole line from last to first non-empty char
map("i", "<leader>l", "<Esc>g_v^", { noremap = true })
map("n", "<leader>l", "<Esc>g_v^", { noremap = true }) -- won't work
map("x", "<leader>l", "<Esc>g_v^", { noremap = true }) -- won't work

-- move around in insert mode
map("i", "<c-k>", "<c-o>gk")
-- map("i", "<C-h>", "<ESC>hi", { noremap = true })
map("i", "<C-l>", "<C-o>l")
map("i", "<C-j>", "<C-o>gj")

-- move character left and right
map("n", "<A-l>", "vxp")
map("n", "<A-h>", "vxhhp")
map("i", "<A-l>", "<ESC>xpi")
map("i", "<A-h>", "<ESC>xhhpi")
map("x", "<A-l>", "xp")
map("x", "<A-h>", "xhhp")

-- go back to last edit
map("n", "<A-#> `.", ":noh<CR>")
map("n", "<A-'> '\" ", ":noh<CR>")

-- turn search highlight off
map("n", "<leader><A-n>", ":noh<CR>")
map("i", "<leader><A-n>", "<ESC>:noh<CR>i")
map("v", "<leader><A-n>", ":noh<CR>")

-- scroll up + get rid of acidental Ctrl + z
map("n", "<C-z>", "<C-y>")
map("i", "<C-z>", "<ESC>l<C-y>i")
map("v", "<C-z>", "<C-y>")

-- go to mark and put it the middle of screen
map("n", "'b", "`b zt")
map("n", "'a", "`a zt")
map("n", "'c", "`c zt")
map("n", "'d", "`d zt")
map("n", "'e", "`e zt")
map("n", "'f", "`f zt")
map("n", "'g", "`g zt")
map("n", "'h", "`h zt")
map("n", "'i", "`i zt")
map("n", "'j", "`j zt")
map("n", "'k", "`k zt")
map("n", "'l", "`l zt")
map("n", "'m", "`m zt")
map("n", "'n", "`n zt")
map("n", "'o", "`o zt")
map("n", "'p", "`p zt")
map("n", "'q", "`q zt")
map("n", "'r", "`r zt")
map("n", "'s", "`s zt")
map("n", "'w", "`w zt")
map("n", "'t", "`t zt")
map("n", "'u", "`u zt")
map("n", "'v", "`v zt")
map("n", "'x", "`x zt")
map("n", "'y", "`y zt")
map("n", "'z", "`z zt")

map("i", "'a", "<ESC>`a zti")
map("i", "'b", "<ESC>`b zti")
map("i", "'c", "<ESC>`c zti")
map("i", "'d", "<ESC>`d zti")
map("i", "'e", "<ESC>`e zti")
map("i", "'f", "<ESC>`f zti")
map("i", "'g", "<ESC>`g zti")
map("i", "'h", "<ESC>`h zti")
map("i", "'i", "<ESC>`i zti")
map("i", "'j", "<ESC>`j zti")
map("i", "'k", "<ESC>`k zti")
map("i", "'l", "<ESC>`l zti")
map("i", "'m", "<ESC>`m zti")
map("i", "'n", "<ESC>`n zti")
map("i", "'o", "<ESC>`o zti")
map("i", "'p", "<ESC>`p zti")
map("i", "'q", "<ESC>`q zti")
map("i", "'r", "<ESC>`r zti")
map("i", "'s", "<ESC>`s zti")
map("i", "'w", "<ESC>`w zti")
map("i", "'t", "<ESC>`t zti")
map("i", "'u", "<ESC>`u zti")
map("i", "'v", "<ESC>`v zti")
map("i", "'x", "<ESC>`x zti")
map("i", "'y", "<ESC>`y zti")
map("i", "'z", "<ESC>`z zti")

-- thePrimeagen Stuff
map("n", "J", "mzJ`z") -- junta a linha de baixo
map("n", "<C-d>", "<C-d>zz") -- mantem cursor no centro
map("n", "<C-u>", "<C-u>zz")
map("x", "<leader>p", '"_dP') -- paste without yanking
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')
map("n", "<leader>d", '"_d')
map("v", "<leader>d", '"_d')

map("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
map("n", "<c-s>", ":SCNvimExt fzf-sc.fuzz<CR>", { silent = true })
