return {
	"hrsh7th/nvim-cmp",
	event = "LspAttach",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- source for lsp completions
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")

		cmp.setup({
			completeopt = "menu,menuone,preview,noselect",

			-- keymaps
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<S-Tab>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<C-y>"] = cmp.mapping.confirm({ select = false }),
			}),

			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- lsp completions
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),

			window = {
				documentation = cmp.config.window.bordered(),
				-- completion = cmp.config.window.bordered(),
			},

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol",
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}
