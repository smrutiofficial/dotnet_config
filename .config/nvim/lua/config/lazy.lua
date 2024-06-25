local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				colorscheme = "sonokai",
				news = {
					lazyvim = true,
					neovim = true,
				},
			},
		},
		{ import = "lazyvim.plugins.extras.linting.eslint" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.lang.tailwind" },
		{ import = "lazyvim.plugins.extras.coding.copilot" },
		{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
		{ import = "plugins" },
		-- Emmet-vim plugin configuration
		{
			"mattn/emmet-vim",
			config = function()
				vim.g.user_emmet_leader_key = "sk"
				vim.g.user_emmet_mode = "a"
			end,
		},
		-- LSP configuration for Emmet
		{
			"neovim/nvim-lspconfig",
			config = function()
				require("lspconfig").emmet_ls.setup({
					filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
					init_options = {
						html = {
							options = {
								["jsx.enabled"] = true,
								["tsx.enabled"] = true,
							},
						},
					},
				})
			end,
		},
	},
	defaults = {
		lazy = false,
		version = false,
	},
	dev = {
		path = "~/.ghq/github.com",
	},
	checker = { enabled = true },
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	debug = false,
})
