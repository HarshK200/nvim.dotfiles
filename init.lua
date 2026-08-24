--------------------------------  Lazy.nvim Plugin Manager ----------------------------------
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},

	-- diable luarocks as i don't use any plugins that use luarocks *gets rid of that annoying warning too*
	rocks = {
		enabled = false,
	},

	-- disable automatically check for plugin updates
	checker = { enabled = false },
	change_detection = {
		enabled = true,
		notify = false,
	},
})

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

-- Hides netrw banner
vim.g.netrw_banner = 0

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

vim.keymap.set("n", "-", ":Ex<CR>", { silent = true })

------------------------------   Auto Commands  -------------------------------
-- enables highlight when yanking/copying
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlights the text when yanked",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- disable that annoying make new buffer in netrw keybind
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function(args)
		for _, map in ipairs(vim.api.nvim_buf_get_keymap(args.buf, "n")) do
			-- check if keymap is set before deleting
			if map.lhs == "t" then
				vim.keymap.del("n", "t", { buffer = args.buf })
				break
			end
		end
	end,
})

-- removes the annoying sort-by keybind of netrw
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "s", "<Nop>", { buffer = true })
		vim.keymap.set("n", "<F1>", "<Nop>", { buffer = true })
	end,
})

vim.api.nvim_create_user_command("T", "vsplit | terminal nu", { bang = false })
