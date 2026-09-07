return {
	"HarshK200/cold.nvim",
	lazy = false,
	priority = 1000,
	init = function()
        require("cold").setup({
            cursorline = true
        })
		vim.cmd.colorscheme("cold")
	end,
}
