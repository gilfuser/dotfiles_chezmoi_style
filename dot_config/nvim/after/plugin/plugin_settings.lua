require("neoscroll").setup({
	easing_function = "sine",
})

require("gruvbox").setup({
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "hard", -- can be "hard", "soft" or empty string
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
	style = "night",
	light_style = "day",
	transparent = false,
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "normal", -- style for sidebars, see below
		floats = "normal", -- style for floating windows
	},
	sidebars = { "qf", "vista_kind", "terminal", "packer" },
	on_colors = function(colors)
		colors.hint = colors.orange
		colors.error = "#ff0000"
	end,
	on_highlights = function(hl, c)

		hl.PmenuSel = { bg = "#282C34", fg = "NONE" }
		hl.Pmenu = { fg = "#C5CDD9", bg = "#22252A" }

		hl.CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", fmt = "strikethrough" }
		hl.CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", fmt = "bold" }
		hl.CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", fmt = "bold" }
		hl.CmpItemMenu = { fg = "#C792EA", bg = "NONE", fmt = "italic" }

		hl.CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" }
		hl.CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" }
		hl.CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" }

		hl.CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" }
		hl.CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" }
		hl.CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" }

		hl.CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" }
		hl.CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" }
		hl.CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" }

		hl.CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" }
		hl.CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" }
		hl.CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" }
		hl.CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" }
		hl.CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" }

		hl.CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" }
		hl.CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294"}

		hl.CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" }
		hl.CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" }
		hl.CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" }

		hl.CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" }
		hl.CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" }
		hl.CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" }

		hl.CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" }
		hl.CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" }
		hl.CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" }
	end,
})

local function scstatus()
	if vim.bo.filetype == "supercollider" then
		local stat = vim.fn["scnvim#statusline#server_status"]()
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

-- local function scstatus()
-- 	if vim.bo.filetype == "supercollider" then
-- 		local stat = vim.fn["scnvim#statusline#server_status"]()
-- 		stat = stat:gsub("%%", "♪")
-- 		return stat
-- 	else
-- 		return ""
-- 	end
-- end

--               ////////////// SCNvim ///////////////

local scnvim = require("scnvim")
local map = scnvim.map
local map_expr = scnvim.map_expr

require("scnvim.postwin").on_open:append(function()
	vim.opt_local.wrap = true
end)

scnvim.setup({
	keymaps = {
		["<M-e>"] = map("editor.send_line", { "i", "n" }),
		-- ["<localleader><Esc>"] = map("editor.send_line", { "i", "n" }),
		["<leader><Esc>"] = {
			map("editor.send_block", { "i", "n" }),
			map("editor.send_selection", "x"),
		},
		["<CR>"] = map("postwin.toggle"),
		["<M-CR>"] = map("postwin.toggle", "i"),
		["<M-P>"] = map("postwin.clear", { "n", "i" }),
		["<C-k>"] = map("signature.show", { "n", "i" }),
		["<F12>"] = map("sclang.hard_stop", { "n", "x", "i" }),
		["<leader>st"] = map("sclang.start"),
		["<leader>sk"] = map("sclang.recompile"),
		["<F1>"] = map_expr("s.boot"),
		["<F2>"] = map_expr("s.meter"),
		["<F3>"] = map_expr("s.makeGui"),
		["<F4>"] = map_expr("CmdPeriod.run"),
	},
	editor = {
		highlight = {
			color = "IncSearch",
		},
	},
	postwin = {
		float = {
			enabled = false,
		},
	},
	extensions = {
		-- ["fzf-sc"] = {
		--     search_plugin = "nvim-fzf",
		-- },
	},
	snippet = {
		engine = {
			name = "luasnip",
		},
	},
})

-- scnvim.load_extension("fzf-sc")

-- Vim Tidal

-- vim.g.tidal_target = "terminal"

-- ///////////////////// Surround /////////////////////// --

require("nvim-surround").setup({
	keymaps = {
		insert = "<leader-s>",
		insert_line = "<C-g>S",
		normal = "ys",
		normal_cur = "yss",
		normal_line = "yS",
		normal_cur_line = "ySS",
		visual = "S",
		visual_line = "gS",
		delete = "ds",
		change = "cs",
	},
	aliases = {
		["<"] = "t",
	},
})

-- /////////////////// Hop //////////////////////// --

-- place this in one of your configuration file(s)
require("hop").setup({})
local hop = require("hop")
local directions = require("hop.hint").HintDirection
local function mapkey(m, k, v, d)
	vim.keymap.set(m, k, v, d)
end

mapkey("", "f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true, desc = "find character forwards the current line" })
mapkey("", "F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true, desc = "[F]ind character backwards in the current line" })
mapkey("", "t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true, desc = "go forwards next [t]o the character in the current line" })
mapkey("", "T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true, desc = "go backwards next [T]o character in current line" })

mapkey("", "<C-f>", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true, desc = "find character forwards the current line" })
mapkey("", "<C-F>", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true, desc = "[F]ind character backwards in the current line" })
mapkey("", "<C-t>", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true, desc = "go forwards next [t]o the character in the current line" })
mapkey("", "<C-T>", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true, desc = "go backwards next [T]o character in current line" })

mapkey("n", "<A-7>", "<CMD>HopPattern<CR>", { desc = 'HopPattern is like neovim search "/"' })

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.completion.spell,
	},
})

-- You don't need to set any of these options.
-- IMPORTANT!: this is only a showcase of how you can set default options!
require("telescope").setup({
	extensions = {
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					-- your custom normal mode mappings
				},
			},
		},
	},
})
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension("file_browser")
