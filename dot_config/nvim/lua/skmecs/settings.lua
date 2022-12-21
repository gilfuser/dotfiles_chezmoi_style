local g = vim.g
local o = vim.o
local set = vim.opt

-- cmd('syntax on')
-- vim.api.nvim_command('filetype plugin indent on')

set.termguicolors = true
-- o.background = 'dark'

-- Do not save when switching buffers
-- o.hidden = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI
o.number = true
o.numberwidth = 5
o.relativenumber = true
o.signcolumn = "yes:2"
o.cursorline = true

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 0
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = "unnamedplus"

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50
-- Better buffer splitting
o.splitright = true

o.splitbelow = true

-- Preserve view while jumping
o.jumpoptions = "view"

-- g.tidal_target = "terminal"
-- BUG: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
o.foldmethod = "indent"
set.foldcolumn = "1"
-- o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1

-- keep marks between sessions
set.viminfo = "'1000,f1"
-- require("bufferline").setup({})
vim.cmd([[
" To automatically reload upon save, add the following to your $MYVIMRC:
if has ('autocmd')
    augroup vimrc " Source vim config upon save
        autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
        autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
    augroup END
    augroup my_filetype_settings
        autocmd!
        autocmd FileType help if winnr('$') > 2 | wincmd K | else | wincmd L | endif
    augroup END
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
