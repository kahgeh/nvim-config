local M = {
  "sQVe/sort.nvim",
  event = "VeryLazy"
}

function M.config()
  require("sort").setup({ })
end

return M
