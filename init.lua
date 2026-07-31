------------------------------  Lazy.Plugin  -------------------------------
require("lazy_nvim")

------------------------------    Keymaps    -------------------------------

-- copy to system keyboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- keymaps to shift highlighted line up/down (shift + k) (shift + j)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- press '-'to navigate 1 back in netrw (disable cause using nvim-tree instead)
-- vim.keymap.set("n", "-", ":Ex<cr>", { desc = "go back one file"})

------------------------------   Set Config  -------------------------------

-- Set leader
vim.g.mapleader = " "

-- Sets line numbers and relativenumber
vim.opt.number = true
vim.opt.relativenumber = true

-- Remove highlighted search
vim.opt.hlsearch = false

-- Setting tab width to 4 spaces instead of default 8
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set word/line wrap to false
vim.opt.wrap = false

-- gives 4 lines of padding to cursor when scrolling off-page
vim.opt.scrolloff = 4

-- split windows default side
vim.opt.splitright = true -- split vertical to right side
vim.opt.splitbelow = true -- split horizontally to bottom

-- column on the right side to remind me of max line length
vim.opt.colorcolumn = "90"

-- changing the stupid fu*king sql filetype plugin omin_key from ctrl+c to ctrl+j
vim.g.ftplugin_sql_omni_key = "<C-j>"

-- remapping tabs to t1, t2, t3 and so on...
vim.keymap.set("n", "tn", ":tab split<CR>", { silent = true })
vim.keymap.set("n", "to", ":tabonly<CR>", { silent = true })
for i = 1, 9 do
	vim.keymap.set("n", "t" .. i, ":tabn" .. i .. "<CR>")
end
