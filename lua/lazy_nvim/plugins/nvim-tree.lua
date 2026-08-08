return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			filters = {
				enable = false, -- disable file filters so all of the files appear in tree
				dotfiles = false,
			},
			renderer = {
				highlight_git = "name",

				icons = {
					show = {
						git = false,
					},
				},
				root_folder_label = function(root_cwd)
					return vim.fn.fnamemodify(root_cwd, ":t")
				end,
			},
			diagnostics = {
				enable = true,
			},
		})

		local api = require("nvim-tree.api")

		-- toggle explorer nvim tree
		vim.keymap.set("n", "<leader>t", function()
			api.tree.toggle({ focus = false })
		end)

		-- find file in explorer i.e. nvim tree
		vim.keymap.set("n", "<leader>ft", function()
			api.tree.find_file({ open = true, focus = true })
		end)
	end,
}
