return {
	"echasnovski/mini.comment",
	version = false,
	opts = {},
	config = function()
		require("mini.comment").setup({
			mappings = {
				-- Comment toggle current line (Normal mode)
				comment_line = "<leader>cl",

				-- Comment toggle selection (Visual mode)
				comment_visual = "<leader>cl",
			},
		})
	end,
}
