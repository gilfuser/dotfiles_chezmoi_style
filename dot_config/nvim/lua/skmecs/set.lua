local o = vim.o
local g = vim.g
local set = vim.opt

--vim.opt.guicursor = ""

set.nu = true
set.relativenumber = true

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true

set.smartindent = true

set.wrap = true

set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

set.hlsearch = false
set.incsearch = true

set.termguicolors = true

set.scrolloff = 8
set.signcolumn = "yes"
set.isfname:append("@-@")

set.updatetime = 50

set.colorcolumn = "80"
-- Remember 50 items in commandline history
o.history = 50
-- Better buffer splitting
o.splitright = true

o.splitbelow = true

-- Preserve view while jumping
o.jumpoptions = "view"

-- keep marks between sessions
set.viminfo = "'1000,f1"

vim.cmd([[
" To automatically reload upon save, add the following to your $MYVIMRC:
if has ('autocmd')
    augroup vimrc " Source vim config upon save
        autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
        autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
    augroup END
    " augroup my_fi:letype_settings
    "     autocmd!
    "     autocmd FileType help if winnr('$') > 2 | wincmd K | else | wincmd L | endif
    " augroup END
    augroup remember_folds
        autocmd!
        autocmd BufWinLeave ?* mkview | filetype detect
        autocmd BufWinEnter ?* silent loadview | filetype detect
    augroup END
endif " has autocmd

" The first line maps escape to the caps lock key when you enter Vim, and the second line returns normal functionality to caps lock when you quit.
" au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
" au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'
]])
