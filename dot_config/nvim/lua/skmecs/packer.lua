return require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- Package manager
	-- style stuff
	use("ellisonleao/gruvbox.nvim")
	use("folke/tokyonight.nvim")
	use("Shatur/neovim-ayu")
	use("nvim-lualine/lualine.nvim")
	use("p00f/nvim-ts-rainbow")
	-- ----------------
	use("neovim/nvim-lspconfig") -- Configurations for Nvim Wow!
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp")
	use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" })
	use("saadparwaiz1/cmp_luasnip")

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-context")
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("nvim-treesitter/nvim-treesitter-refactor")

	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("numToStr/Comment.nvim")

	use("folke/trouble.nvim")
	use("folke/lsp-colors.nvim")
	use({ "jose-elias-alvarez/null-ls.nvim" })

	-- Debugging
	use("nvim-lua/plenary.nvim")
	use("mfussenegger/nvim-dap")

	use("vijaymarupudi/nvim-fzf")
	use("davidgranstrom/scnvim")
	use("ibhagwan/fzf-lua")
	use("~/builds/fzf-sc")
	-- use("gilfuser/fzf-sc")
	use("davidgranstrom/scnvim-tmux")
	use("tidalcycles/vim-tidal")

	use("windwp/nvim-autopairs")
	use("kylechui/nvim-surround")
	use("zhou13/vim-easyescape")
	use("karb94/neoscroll.nvim")
	use({ "kyazdani42/nvim-tree.lua", tag = "nightly" })
	use({ "phaazon/hop.nvim", branch = "v2" })

	-- use("christoomey/vim-tmux-navigator")
	use("jbyuki/instant.nvim")

	use("Pocco81/true-zen.nvim")
	use("nvim-tree/nvim-web-devicons")
end)
