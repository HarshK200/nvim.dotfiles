return {
	-- The little lsp server loading progress thigi that appears on the bottom right of the screen
	"j-hui/fidget.nvim",
    event = "LspAttach",
	config = function()
		require("fidget").setup({})
	end,
}
