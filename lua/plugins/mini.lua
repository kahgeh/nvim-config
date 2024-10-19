local M = {
	"echasnovski/mini.nvim",
	version = "*",
}

function M.config()
	require("mini.animate").setup({})
end

return M
