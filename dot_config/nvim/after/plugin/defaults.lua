--local g = vim.g
local o = vim.o
--local set = vim.opt

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 4

-- Better editor UI
-- o.numberwidth = 5
o.relativenumber = true
-- o.signcolumn = "yes:2"

-- Better editing experience
--o.expandtab = true
o.smarttab = true
--o.cindent = true
o.autoindent = true
o.wrap = true
--o.textwidth = 300
o.tabstop = 4
--o.shiftwidth = 0
--o.softtabstop = -1 -- If negative, shiftwidth value is used
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

-- Remember 50 items in commandline history
o.history = 50
-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
o.jumpoptions = "view"

-- Better folds (don't fold by default)
o.foldmethod = "indent"
o.foldcolumn = "1"
o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1

