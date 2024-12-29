-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<Leader>a", "gg<S-v>G")

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NvimTree
keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
keymap.set("n", "<Leader>m", ":NvimTreeToggle<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit<Return>", { silent = true })
keymap.set("n", "<tab>", ":tabnext<Return>", { silent = true }, opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", { silent = true }, opts)
keymap.set("n", "tw", ":tabclose<Return>", { silent = true }, opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
keymap.set("n", "sx", "<cmd>close<CR>", opts)

-- Move window
keymap.set("n", "<A-s>", "<C-w>w")
keymap.set("n", "s<left>", "<C-w>h")
keymap.set("n", "s<Up>", "<C-w>k")
keymap.set("n", "s<Down>", "<C-w>j")
keymap.set("n", "s<Right>", "<C-w>l")
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

-- Custom keybindings
keymap.set("i", "jk", "<ESC>:w<CR>", opts)
keymap.set("x", "jk", "<ESC>:w<CR>", opts)
--move cursor in normal mode
keymap.set("n", "<Leader>l", "$", opts)
keymap.set("n", "<Leader>h", "0", opts)
keymap.set("n", "<Leader>k", "gg", opts)
keymap.set("n", "<Leader>j", "G", opts)
--remap visual key
keymap.set("n", "<Leader>v", "v", opts)

keymap.set("i", "<A-p>", "<ESC>p$i", opts)
-- Comment
keymap.set("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
keymap.set("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })
-- move cursor in insert mode
-- keymap.set("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line", remap = true })
-- keymap.set("i", "<C-e>", "<End>", { desc = "move end of line", remap = true })
--
keymap.set("i", "<A-h>", "<Left>", { desc = "move left", remap = true })
keymap.set("i", "<A-l>", "<Right>", { desc = "move right", remap = true })
keymap.set("i", "<A-j>", "<Down>", { desc = "move down", remap = true })
keymap.set("i", "<A-k>", "<Up>", { desc = "move up", remap = true })

-- New keybindings for moving selected lines up/down and repeatable until Esc
keymap.set("x", "<C-k>", ":m '<-2<CR>gv=gv", opts) -- Move selected lines up
keymap.set("x", "<C-j>", ":m '>+1<CR>gv=gv", opts) -- Move selected lines down

-- Copy selected lines and paste them at the end of the selection line +1 and at the first line of the selection -1
keymap.set("x", "<C-l>", '"my`>+1<CR>gv:put m<CR>gv', opts) -- Copy to m register and paste below the selection
keymap.set("x", "<C-h>", '"my`< -1<CR>gv:put m<CR>gv', opts)

keymap.set("x", "as", ':<C-u>s/\\%V\\(.*\\)/"\\1"<CR>')
-- Navigate diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)