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
keymap.set("n", "<Leader>n", ":NvimTreeToggle<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
keymap.set("n", "sx", "<cmd>close<CR>", opts)
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

-- Custom keybindings
keymap.set("i", "jk", "<ESC>", opts)
keymap.set("n", "<Leader>l", "$", opts)
keymap.set("n", "<Leader>h", "^", opts)
keymap.set("n", "<Leader>k", "gg", opts)
keymap.set("n", "<Leader>j", "G", opts)
keymap.set("n", "<Leader>v", "v", opts)

-- New keybindings for moving selected lines up/down and repeatable until Esc
keymap.set("x", "<C-k>", ":m '<-2<CR>gv=gv", opts) -- Move selected lines up
keymap.set("x", "<C-j>", ":m '>+1<CR>gv=gv", opts) -- Move selected lines down

-- Copy selected lines and paste them at the end of the selection line +1 and at the first line of the selection -1
keymap.set("x", "<C-l>", '"my`>+1<CR>gv:put m<CR>gv', opts) -- Copy to m register and paste below the selection
keymap.set("x", "<C-h>", '"my`< -1<CR>gv:put m<CR>gv', opts)

-- Navigate diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)
