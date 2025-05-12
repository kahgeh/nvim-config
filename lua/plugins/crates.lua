local M = {
  "saecki/crates.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  require("crates").setup({
    popup = {
      autofocus = true,
    },
  })
  vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
    pattern = "Cargo.toml",
    callback = function()
      require("cmp").setup.buffer({ sources = { { name = "crates" } } })
    end,
  })
end

return M
