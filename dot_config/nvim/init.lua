local o = vim.o
local g = vim.g
local set = vim.opt
-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

g.mapleader = "ö"
g.maplocalleader = ","

vim.cmd([[
    syntax enable
    :nmap ç ö
    set nocp                    " 'compatible' is not set
    filetype plugin on          " plugins are enabled
]])

g.python2_host_prog = "/usr/bin/python2"
g.python3_host_prog = "/usr/bin/python3"

g.instant_username = "skmecs"

-- require("plugins")
require("skmecs")
