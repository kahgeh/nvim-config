local M = {
  "lunarvim/darkplus.nvim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function ()
    vim.cmd ([[
      colorscheme darkplus
    ]])
  end  
}

M.name = "darkplus"

function M.config()
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
