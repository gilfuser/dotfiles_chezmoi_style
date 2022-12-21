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
		["fzf-sc"] = {
			search_plugin = "nvim-fzf",
		},
	},
})

scnvim.load_extension("fzf-sc")
