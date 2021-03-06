local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("user.lsp.configs")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")

local notify = vim.notify
vim.notify = function(msg, ...)
	if type(msg) == "string" and msg:match("%[lspconfig] Autostart for") then
		-- Do not show LSP autostart failed messages
		return
	end

	notify(msg, ...)
end
