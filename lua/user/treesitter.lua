local status_ok, _ = pcall(require, "nvim-treesitter")
if not status_ok then
	return
end

local config_status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not config_status_ok then
	return
end

configs.setup({
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "yaml" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<A-v>",
			node_incremental = "<A-v>",
			scope_incremental = "<tab>",
			node_decremental = "<A-V>",
		},
	},
	ensure_installed = {
		"bash",
		"c",
		"javascript",
		"json",
		"lua",
		"python",
		"typescript",
		"tsx",
		"css",
		"rust",
		"java",
		"yaml",
		"c_sharp",
	},
})
