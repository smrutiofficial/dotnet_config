-- init.lua

-- Enable the loader if it exists
if vim.loader then
	vim.loader.enable()
end

-- Define a global debug function
_G.dd = function(...)
	require("util.debug").dump(...)
end

-- Set vim.print to the global debug function
vim.print = _G.dd

-- Load options, keymaps, and other configurations
require("config.options")
require("config.keymaps")
require("config.workflows")

-- Load lazy plugin manager configuration
require("config.lazy")
