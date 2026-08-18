return {
	"stevearc/conform.nvim",
	-- lazy load on keymap
	events = "LspAttach",
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
