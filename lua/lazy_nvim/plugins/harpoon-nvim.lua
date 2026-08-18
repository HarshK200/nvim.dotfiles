return {
	"theprimeagen/harpoon",
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "Add file to harpoon list",
		},
		{
			"<C-e>",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "Toggle harpoon quick menu",
		},
		{
			"<C-h>",
			function()
				require("harpoon.ui").ui.nav_file(1)
			end,
		},
		{
			"<C-i>",
			function()
				require("harpoon.ui").ui.nav_file(2)
			end,
		},
		{
			"<C-o>",
			function()
				require("harpoon.ui").ui.nav_file(3)
			end,
		},
		{
			"<C-p>",
			function()
				require("harpoon.ui").ui.nav_file(4)
			end,
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

		vim.keymap.set("n", "<C-h>", function()
			ui.nav_file(1)
		end)
		vim.keymap.set("n", "<C-i>", function()
			ui.nav_file(2)
		end)
		vim.keymap.set("n", "<C-o>", function()
			ui.nav_file(3)
		end)
		vim.keymap.set("n", "<C-p>", function()
			ui.nav_file(4)
		end)
	end,
}
