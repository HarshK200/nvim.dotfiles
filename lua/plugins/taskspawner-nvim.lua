return {
	"TaskSpawner",
	dir = vim.fn.stdpath("config") .. "/lua/personal_plugins",
	-- lazy loaded on key press
	keys = { "<M-t>" },
	-- lazy loaded on command Spawn or SpawnPrevious
	cmd = { "Spawn", "SpawnPrevious" },
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("personal_plugins.taskspawner").setup()

		-- keymaps setup
		vim.keymap.set("n", "<M-t>", "<cmd>SpawnPrevious<cr>")
	end,
}
