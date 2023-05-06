local M = {
	"phaazon/hop.nvim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
}

M.config = function()
	require("hop").setup()
end

return M
