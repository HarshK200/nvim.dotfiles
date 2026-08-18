return {
	"echasnovski/mini.comment",
    -- lazy load on buffer read
	event = { "BufReadPost", "BufNewFile" },
	version = false,
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
