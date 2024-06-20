if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")

-- init.lua or init.vim
return require("lazy").setup({
	{
		"mattn/emmet-vim",
		config = function()
			vim.g.user_emmet_leader_key = "sk"
			vim.g.user_emmet_mode = "a"
		end,
	},
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
})
