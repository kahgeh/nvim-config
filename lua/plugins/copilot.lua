local M = {
  "github/copilot.vim",
  event = "VeryLazy",
}

function M.config()
  vim.g.copilot_filetypes = { xml = false, json = false, markdown = false }
  vim.cmd([[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]])

  vim.g.copilot_no_tab_map = true
  vim.cmd([[highlight CopilotSuggestions guifg=#555555  ctermfg=8]])
end

return M
