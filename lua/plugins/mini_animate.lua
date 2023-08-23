local M = {
	"echasnovski/mini.nvim",
	version = "*",
	event = "BufRead",
}

function M.config()
	require("mini.animate").setup()
end

return M
