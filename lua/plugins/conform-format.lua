return {
	"stevearc/conform.nvim",
	-- lazy load on keymap
	event = "LspAttach",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				odin = { "odinfmt" },
				json = { "prettier" },
                cpp = { "clang-format" },
			},
		})

		vim.keymap.set("n", "<leader>ff", function()
			require("conform").format()
		end)
	end,
}
