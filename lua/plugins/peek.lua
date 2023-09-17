local M = {
  "toppair/peek.nvim",
  event = "BufRead",
  ft = { "markdown" },
}

function M.config()
  require("peek").setup({
    filetype = { "markdown" },
    app = "browser"
  })
  vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
  vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
end

function M.build()

end

return M
