return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false, -- treesitter doesn't support lazy loading
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- install language parsers that i use
		local my_languages = {
			"lua",
			"javascript",
			"typescript",
			"go",
		}
		require("nvim-treesitter").install(my_languages)
	end,
}
