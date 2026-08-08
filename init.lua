-- NOTE: THIS IS EXPERIMENTAL FEATURE
if vim.loader then
	vim.loader.enable()
end

--------------------------------  Plugin  ----------------------------------
require("lazy_nvim")

------------------------------    Keymaps    -------------------------------

-- copy to system keyboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- keymaps to shift highlighted line up/down (shift + k) (shift + j)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

------------------------------   Set Config  -------------------------------

-- Set leader
vim.g.mapleader = " "

-- remove ~ from empty line
vim.opt.fillchars:append({ eob = " " })

-- Sets line numbers and relativenumber
vim.opt.number = true
vim.opt.relativenumber = true

-- Reserve sign column for git sign and etc
vim.opt.signcolumn = "yes:1"

-- Set word/line wrap to false
vim.opt.wrap = false

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- Setting autoindentation true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Remove highlighted search
vim.opt.hlsearch = false

-- Enables 24-bit color in the TUI
vim.opt.termguicolors = true

-- Setting tab width to 4 spaces instead of default 8
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- gives 4 lines of padding to cursor when scrolling off-page
vim.opt.scrolloff = 4

-- split windows default side
vim.opt.splitright = true -- split vertical to right side
vim.opt.splitbelow = true -- split horizontally to bottom

-- changing the stupid fu*king sql filetype plugin omin_key from ctrl+c to ctrl+j
vim.g.ftplugin_sql_omni_key = "<C-j>"

-- The swap file and backup file stuff like the . file it creates and shit annoying stuff turning it off
vim.opt.swapfile = false
vim.opt.backup = false

-- remapping tabs to t1, t2, t3 and so on...
vim.keymap.set("n", "tn", ":tab split<CR>", { silent = true })
vim.keymap.set("n", "to", ":tabonly<CR>", { silent = true })
for i = 1, 9 do
	vim.keymap.set("n", "t" .. i, ":tabn" .. i .. "<CR>")
end
