return function(use)
  -- use {
  --   "folke/which-key.nvim",
  --   config = function() require("which-key").setup {} end
  -- }
  -- style stuff
  use("ellisonleao/gruvbox.nvim")
  use("folke/tokyonight.nvim")
  use("Shatur/neovim-ayu")
  -- use("p00f/nvim-ts-rainbow")
  -- ----------------
  use({ "jose-elias-alvarez/null-ls.nvim" })

  -- use("vijaymarupudi/nvim-fzf")
  use("davidgranstrom/scnvim")
  -- use("ibhagwan/fzf-lua")
  -- use("gilfuser/fzf-sc")
  -- use("davidgranstrom/scnvim-tmux")
  use("tidalcycles/vim-tidal")

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {
      map_c_h = true,  -- Map the <C-h> key to delete a pair
      map_c_w = true
    } end
  }
  use {
    "kylechui/nvim-surround",
    tag = "*",
    config = function() require("nvim-surround").setup {} end
  }
  use("zhou13/vim-easyescape")
  use("karb94/neoscroll.nvim")
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-configplu
      require'hop'.setup {
	uppercase_labels = true,
      }
    end
  }
  -- Lua
  use {
    "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup { } end,
  }

  use("jbyuki/instant.nvim")
  use("nvim-tree/nvim-web-devicons")
  use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
  use("xiyaowong/nvim-transparent")
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use {
  "nvim-telescope/telescope.nvim",
  requires = {
    { "nvim-telescope/telescope-live-grep-args.nvim" },
  },
  config = function()
    require("telescope").load_extension("live_grep_args")
  end
}
end

