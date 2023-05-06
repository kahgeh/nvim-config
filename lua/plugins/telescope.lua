local M = {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.1",
	event = "Bufenter",
	cmd = { "Telescope" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

M.opts = {
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },
	},
}

return M
