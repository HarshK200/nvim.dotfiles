local catppuccin = "catppuccin/nvim"
local rosepine = "rose-pine/neovim"
local tokyonight = "folke/tokyonight.nvim"
local solarized_osaka = "craftzdog/solarized-osaka.nvim"
local gruvbox = "ellisonleao/gruvbox.nvim"

return {
	gruvbox,
	config = function()
		--solarized_osaka theme
		--vim.cmd[[colorscheme solarized_osaka]]

		vim.o.background = "dark" -- or "light" for light mode
		vim.cmd([[colorscheme gruvbox]])
		-- Below two lines makes the window transparent
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end,
	opts = ...,
}
