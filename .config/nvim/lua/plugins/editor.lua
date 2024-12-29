-- Return a table that defines editor-related plugins and their configurations
return {
	-- Highlight colors using the mini.hipatterns plugin
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre", -- Load this plugin before reading a buffer
		opts = {}, -- Default options (can be customized if needed)
	},

	-- Telescope: Fuzzy Finder and File Browser
	{
		"telescope.nvim", -- Core Telescope plugin
		priority = 1000, -- Load this plugin early to ensure dependencies are resolved
		dependencies = { -- Define plugins required by Telescope
			{
				"nvim-telescope/telescope-fzf-native.nvim", -- Improved sorting performance
				build = "make", -- Build the fzf-native plugin
			},
			"nvim-telescope/telescope-file-browser.nvim", -- File browser extension
		},
		keys = { -- Keybindings to trigger Telescope functionalities
			{
				";f", -- Key combination
				function()
					-- Lists files in the current directory, including hidden files
					local builtin = require("telescope.builtin")
					builtin.find_files({ no_ignore = false, hidden = true })
				end,
				desc = "Lists files in your current working directory, respects .gitignore",
			},
			{
				";r",
				function()
					-- Live search for strings in the current directory
					local builtin = require("telescope.builtin")
					builtin.live_grep()
				end,
				desc = "Search for a string in your current working directory",
			},
			{
				"\\\\",
				function()
					-- Lists all open buffers
					local builtin = require("telescope.builtin")
					builtin.buffers()
				end,
				desc = "Lists open buffers",
			},
			{
				";;",
				function()
					-- Resumes the previous Telescope search picker
					local builtin = require("telescope.builtin")
					builtin.resume()
				end,
				desc = "Resume the previous telescope picker",
			},
			{
				";e",
				function()
					-- Lists diagnostics for open buffers
					local builtin = require("telescope.builtin")
					builtin.diagnostics()
				end,
				desc = "Lists Diagnostics for all open buffers or a specific buffer",
			},
			{
				";s",
				function()
					-- Lists functions, variables, and symbols using Treesitter
					local builtin = require("telescope.builtin")
					builtin.treesitter()
				end,
				desc = "Lists Function names, variables, from Treesitter",
			},
			{
				"sf",
				function()
					-- Opens a file browser with the current buffer's path
					local telescope = require("telescope")

					-- Get the directory of the current buffer
					local function telescope_buffer_dir()
						return vim.fn.expand("%:p:h")
					end

					-- Open the file browser with custom settings
					telescope.extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = telescope_buffer_dir(),
						respect_gitignore = false,
						hidden = true,
						grouped = true,
						previewer = false,
						initial_mode = "normal",
						layout_config = { height = 40 },
					})
				end,
				desc = "Open File Browser with the path of the current buffer",
			},
		},
		config = function(_, opts) -- Configuration function for Telescope
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local fb_actions = require("telescope").extensions.file_browser.actions

			-- Default Telescope settings
			opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
				wrap_results = true, -- Wrap results in the Telescope window
				layout_strategy = "horizontal", -- Use a horizontal layout
				layout_config = { prompt_position = "top" }, -- Position the prompt at the top
				sorting_strategy = "ascending", -- Sort results in ascending order
				winblend = 0, -- Transparency level for Telescope window
				mappings = { -- Custom mappings for Telescope
					n = {}, -- Define normal mode mappings (empty here)
				},
			})

			-- Custom picker settings
			opts.pickers = {
				diagnostics = {
					theme = "ivy", -- Use the 'ivy' theme
					initial_mode = "normal", -- Start in normal mode
					layout_config = {
						preview_cutoff = 9999, -- Always show full preview
					},
				},
			}

			-- File browser extension settings
			opts.extensions = {
				file_browser = {
					theme = "dropdown", -- Use a dropdown menu for file browsing
					hijack_netrw = true, -- Replace netrw with Telescope's file browser
					mappings = {
						["n"] = { -- Normal mode mappings for file browser
							["N"] = fb_actions.create, -- Create a new file/directory
							["h"] = fb_actions.goto_parent_dir, -- Navigate to parent directory
							["<C-u>"] = function(prompt_bufnr) -- Scroll up by 10 lines
								for i = 1, 10 do
									actions.move_selection_previous(prompt_bufnr)
								end
							end,
							["<C-d>"] = function(prompt_bufnr) -- Scroll down by 10 lines
								for i = 1, 10 do
									actions.move_selection_next(prompt_bufnr)
								end
							end,
						},
					},
				},
			}

			-- Apply the configured settings
			telescope.setup(opts)

			-- Load Telescope extensions
			require("telescope").load_extension("fzf") -- Fuzzy finder extension
			require("telescope").load_extension("file_browser") -- File browser extension
		end,
	},
}
