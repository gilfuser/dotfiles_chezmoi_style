local ft = require('Comment.ft')
 require('Comment').setup( {
    ignore = '^$',
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
        line = '<leader>ci',
        block = '<leader>cb',
    },
    opleader = {
        line = '<leader>c',
        block = '<leader>b',
    },
    extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
    },
    mappings = {
        basic = true,
        extra = true,
        extended = false,
    },
    pre_hook = nil,
    post_hook = nil,
} )
ft.set('tidal', '--%s')
