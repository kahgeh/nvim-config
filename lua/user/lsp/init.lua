local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.lsp.lsp-installer"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"

lspconfig.powershell_es.setup({
	bundle_path = "/Users/kahgeh.tan/bin/pwsh_es",
})


