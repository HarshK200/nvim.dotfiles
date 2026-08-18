return {
	"TaskSpawner",
	dir = vim.fn.stdpath("config") .. "/lua/personal_plugins",
	-- lazy loaded on keybind
	keys = {
		{ "<M-t>", "<cmd>SpawnPrevious<cr>", "Run previous task" },
	},
	-- lazy loaded on command Spawn or SpawnPrevious
	cmd = { "Spawn", "SpawnPrevious" },
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("personal_plugins.taskspawner").setup()
		vim.keymap.set("n", "<M-t>", "SpawnPrevious")
	end,
}
