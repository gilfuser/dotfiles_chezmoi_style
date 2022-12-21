local o = vim.o
local set = vim.opt

-- Better folds (don't fold by default)
o.foldmethod = "indent"
set.foldcolumn = "1"
o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1
