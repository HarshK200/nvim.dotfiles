return {
	"folke/trouble.nvim",
	-- lazy load on following key press
	keys = { "<leader>xx", "<leader>xX", "<leader>cs" },
	-- lazy load when command Trouble is used
	cmd = "Trouble",
	config = function()
		-- keymaps
		vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
		vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
		vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>")
	end,
}
