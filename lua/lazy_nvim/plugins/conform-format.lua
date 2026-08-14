return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				odin = { "odinfmt" },
                json = { "prettier" },
			},
		})

		vim.keymap.set("n", "<leader>ff", function()
			require("conform").format()
		end)
	end,
}
