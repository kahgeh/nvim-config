local M = {
  'glacambre/firenvim',

  -- Lazy load firenvim
  -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  cond = not not vim.g.started_by_firenvim,
  build = function()
    require("lazy").load({ plugins = "firenvim", wait = true })
    vim.fn["firenvim#install"](0)
  end
}

function M.config()
  vim.g.firenvim_config.localSettings['https:*'] = { takeover = 'never', priority = 1 }
  vim.g.firenvim_config.localSettings['http://localhost*/lab/*'] = { takeover = 'always' }
end

return M
