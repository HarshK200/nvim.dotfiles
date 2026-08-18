return {
	"folke/trouble.nvim",
	opts = {},
	-- lazy load on following key press
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", mode = "n" },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", mode = "n" },
		{ "<leader>cs", "<cmd>Trouble diagnostics symbols toggle focus=false<cr>", mode = "n" },
	},
	-- lazy load when command Trouble is used
	cmd = "Trouble",
}
