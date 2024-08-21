return {
	"itmecho/neoterm.nvim",
	config = function()
		-- Setup global config
		require("neoterm").setup({
			clear_on_run = true, -- run clear command before user specified commands
			mode = "horizontal", -- vertical/horizontal/fullscreen
			noinsert = false, -- disable entering insert mode when opening the neoterm window
		})

		local neoterm = require("neoterm")

		vim.keymap.set("n", "<C-y>", ":NeotermToggle<CR>")
		vim.keymap.set("t", "<C-y>", ":NeotermToggle<CR>")
		vim.keymap.set("i", "<C-y>", "<Esc>:NeotermToggle<CR>")
		vim.keymap.set("t", "<C-y>", "<C-\\><C-n>:NeotermToggle<CR>")

		-- Override global config on a specific open call
		neoterm.open({ mode = "horizontal", noinsert = true })
		neoterm.close()
		neoterm.toggle()
		neoterm.run("ls")
		-- Control whether or not the screen is cleared before running the command
		neoterm.run("ls", { clear = false })
		neoterm.rerun()
		neoterm.exit()
	end,
}
