return {
	"stevearc/conform.nvim",
    -- TODO: change keymap load instead
    -- lazy load on buffer read
    event = { "BufReadPre", "BufNewFile" },
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
