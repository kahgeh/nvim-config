local M = {
	"nvim-pack/nvim-spectre",
}

function M.config()
	require("spectre").setup({})
end

return M
