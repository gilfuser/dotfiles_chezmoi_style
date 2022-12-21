local cmp = require("cmp")
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

 -- for SuperTab Luasnip Mapping
local luasnip = require("luasnip")
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

 cmp.setup({

    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      -- ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
          -- elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-l>"] = cmp.mapping(function(fallback)
          -- if luasnip.jumpable() then
          if luasnip.expand_or_locally_jumpable() then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-h>"] = cmp.mapping(function(fallback)
          -- if luasnip.jumpable() then
          if luasnip.expand_or_locally_jumpable() then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources(
         {
             { name = 'nvim_lua' , keyword_length = 3, max_item_count = 20 },
             { name = 'nvim_lsp',  keyword_length = 3, max_item_count = 20 },
             { name = 'luasnip',  keyword_length = 3, max_item_count = 20  },
             { name = 'path',  keyword_length = 3, max_item_count = 20  },
         },
         {
             { name = 'buffer', keyword_length = 4, max_item_count = 20 },
         }
    ),

     view = {
         entries = 'native'
     },

     experimental = {
      ghost_text = true, -- this feature conflict with copilot.vim's preview.
    }

})


  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  --[[ cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    },
    view = {
    entries = {name = 'wildmenu', separator = '|' }
  },
  }) ]]


  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  --[[ cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  }) ]]

  cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
