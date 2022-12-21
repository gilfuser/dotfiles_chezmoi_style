return require('packer').startup( function(use)

    use "ellisonleao/gruvbox.nvim"
    use 'wbthomason/packer.nvim' -- Package manager
    use 'neovim/nvim-lspconfig' -- Configurations for Nvim Wow!

    use "hrsh7th/nvim-cmp"
    use'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lua'
    use'hrsh7th/cmp-nvim-lsp'

    use {"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"}
    use 'saadparwaiz1/cmp_luasnip'

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    -- use 'nvim-treesitter/playground'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'p00f/nvim-ts-rainbow'
    use { 'ibhagwan/fzf-lua',
        -- optional for icon support
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use { 'junegunn/fzf', run = './install --bin' }

    use 'davidgranstrom/scnvim'
    use 'madskjeldgaard/fzf-sc'
    use 'tidalcycles/vim-tidal'

    use 'numToStr/Comment.nvim'

    use 'windwp/nvim-autopairs'
    use 'kylechui/nvim-surround'
    use 'zhou13/vim-easyescape'
    use 'nvim-lualine/lualine.nvim'
    use 'karb94/neoscroll.nvim'
    use {'kyazdani42/nvim-tree.lua',
     requires = { 'kyazdani42/nvim-web-devicons', -- optional, for file icons
     },
     tag = 'nightly' -- optional, updated every week. (see issue #1193)
     }
    use 'joerdav/floobits-neovim'
    use 'ggandor/leap.nvim'
  end)
