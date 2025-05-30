local M = {
  "toppair/peek.nvim",
  event = "VeryLazy",
  config = function()
    require("peek").setup()
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  end
}

return M
