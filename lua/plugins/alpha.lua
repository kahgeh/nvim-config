local M = {
	"goolord/alpha-nvim",
	event = "VimEnter",
}

function M.config()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")
	dashboard.section.header.val = {
		[[   _  __        _        _   _      ____   U _____ u   _   _    _    ____     ]],
		[[  |"|/ /    U  /"\  u   |'| |'|  U /"___|u \| ___"|/  |'| |'|  |"|  / __"| u  ]],
		[[  | ' /      \/ _ \/   /| |_| |\ \| |  _ /  |  _|"   /| |_| |\ |_| <\___ \/   ]],
		[[U/| . \\u    / ___ \   U|  _  |u  | |_| |   | |___   U|  _  |u      u___) |   ]],
		[[  |_|\_\    /_/   \_\   |_| |_|    \____|   |_____|   |_| |_|       |____/>>  ]],
		[[,-,>> \\,-.  \\    >>   //   \\    _)(|_    <<   >>   //   \\        )(  (__) ]],
		[[ \.)   (_/  (__)  (__) (_") ("_)  (__)__)  (__) (__) (_") ("_)      (__)      ]],
	}
	dashboard.section.buttons.val = {
		dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
		dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
		dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
		dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
		dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
		dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
	}

	local function footer()
		return "10kg"
	end

	dashboard.section.footer.val = footer()

	dashboard.section.footer.opts.hl = "Type"
	dashboard.section.header.opts.hl = "Include"
	dashboard.section.buttons.opts.hl = "Keyword"

	dashboard.opts.opts.noautocmd = true
	alpha.setup(dashboard.opts)
end

return M
