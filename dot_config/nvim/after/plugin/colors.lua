-- set mouse=a
-- " colorscheme one
vim.o.background = "dark" -- or "light" for light mode
-- setup must be called before loading the colorscheme
-- Default options:
require("gruvbox").setup({
	undercurl = true,
	underline = true,
	bold = true,
	italic = true,
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "hard", -- can be "hard", "soft" or empty string
	overrides = {},
	dim_inactive = false,
	transparent_mode = false,
	overrides = {
		-- SignColumn = {bg = "#ff9900"}
		CursorLine = { bg = "#121415" },
	},
})
require("ayu").setup({
	mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
	overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
})

require("tokyonight").setup({
	-- use the night style
	style = "night",
	light_style = "day", -- The theme is used when the background is set to light
	transparent = true, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark", -- style for sidebars, see below
		floats = "dark", -- style for floating windows
	},
	-- disable italic for functions
	styles = {
		functions = {},
	},
	sidebars = { "qf", "vista_kind", "terminal", "packer" },
	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
	on_colors = function(colors)
		colors.hint = colors.orange
		colors.error = "#ff0000"
	end,
})

--require("ayu").colorscheme()
require("tokyonight").colorscheme()

local function scstatus()
	if vim.bo.filetype == "supercollider" then
		stat = vim.fn["scnvim#statusline#server_status"]()
		stat = stat:gsub("%%", "♪")
		return stat
	else
		return ""
	end
end

require("lualine").setup({
	options = {
		theme = "tokyonight",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename", scstatus },
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
--[[
require("transparent").setup({
	enable = false, -- boolean: enable transparent
	extra_groups = { -- table/string: additional groups that should be cleared
		-- In particular, when you set it to 'all', that means all available groups

		-- example of akinsho/nvim-bufferline.lua
		"BufferLineTabClose",
		"BufferlineBufferSelected",
		"BufferLineFill",
		"BufferLineBackground",
		"BufferLineSeparator",
		"BufferLineIndicatorSelected",
	},
	exclude = {}, -- table: groups you don't want to clear
})
--]]
