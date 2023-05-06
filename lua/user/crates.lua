local ok, crates = pcall(require, "crates")
if not ok then
	return
end

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

crates.setup({
	null_ls = {
		enabled = true,
		name = "crates.nvim",
	},
	popup = {
		autofocus = true,
	},
})

vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
	pattern = "Cargo.toml",
	callback = function()
		cmp.setup.buffer({ sources = { { name = "crates" } } })
	end,
})
