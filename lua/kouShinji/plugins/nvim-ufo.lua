return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		vim.o.foldcolumn = "1" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		-- custom fold icons
		vim.cmd([[ set fillchars=foldopen:▾,foldclose:▸ ]])
		vim.cmd([[ highlight Folded guifg=None guibg=None ]])

		-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
		vim.keymap.set("n", "zr", require("ufo").openAllFolds)
		vim.keymap.set("n", "zm", require("ufo").closeAllFolds)
		vim.keymap.set("n", "zk", function()
			local windid = require("ufo").peekFoldedLinesUnderCursor()
			if not windid then
				vim.lsp.buf.hover()
			end
		end)

		require("ufo").setup({
			provider_selector = function()
				return { "lsp" }
			end,
		})
	end,
}
