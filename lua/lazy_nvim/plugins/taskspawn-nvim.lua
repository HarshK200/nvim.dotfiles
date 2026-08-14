return {
	"TaskSpawner",
	dir = vim.fn.stdpath("config") .. "/lua/personal_plugins",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	cmd = "Spawn",
	keys = {
		{ "<M-t>", "Run previous task" },
	},
	config = function()
		require("personal_plugins.taskspawner").setup()
	end,
}
