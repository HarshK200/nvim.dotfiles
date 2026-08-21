return {
	"saghen/blink.cmp",
	-- lazy load on buffer read or new buffer/file open
	event = "LspAttach",
	-- use a release tag to download pre-built binaries
	version = "1.*",
	opts = {
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			-- disable default mappings
			preset = "none",

			-- control completion window, select next, previous and accept
			["<C-p>"] = { "select_prev" },
			["<C-n>"] = { "select_next" },
			["<C-y>"] = { "select_and_accept" },

			["<Tab>"] = { "show" },
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = { documentation = { auto_show = false } },

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
