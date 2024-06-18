local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NvimTree
keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
keymap.set("n", "<Leader>n", ":NvimTreeToggle<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "<Leader>sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "<Leader>sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

-- Custom keybindings
keymap.set("i", "jk", "<ESC>", opts)
keymap.set("n", "<Leader>l", "$", opts)
keymap.set("n", "<Leader>h", "^", opts)
keymap.set("n", "<Leader>k", "gg", opts)
keymap.set("n", "<Leader>j", "G", opts)

-- Ctrl+s for save
keymap.set("n", "<C-s>", ":w<Return>", opts)
keymap.set("i", "<C-s>", "<ESC>:w<Return>a", opts)
-- Ctrl+q for quit
keymap.set("n", "<Leader-q>", ":q<Return>", opts)
keymap.set("i", "<Leader-q>", "<ESC>:q<Return>", opts)
-- Ctrl+w for save and quit
keymap.set("n", "<C-w>", ":wq<Return>", opts)
keymap.set("i", "<C-w>", "<ESC>:wq<Return>", opts)
-- Ctrl+Shift+w for quit without saving
keymap.set("n", "<C-S-w>", ":q!<Return>", opts)
keymap.set("i", "<C-S-w>", "<ESC>:q!<Return>", opts)
