return {
	"mason-org/mason-lspconfig.nvim",
	-- lazy load on buffer read or new buffer/file open
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		ensure_installed = { "lua_ls", "ols", "jsonls" },
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = function()
		-- jump to definition
		vim.keymap.set("n", "gd", vim.lsp.buf.definition)
		-- rename using lsp
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
		-- show available code actions
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
		-- go to previous diagnostics
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end)
		-- go to next diagnostics
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end)
		-- show documentation for what is under cursor
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end)

		-- Custom Diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.HINT] = signs.Hint,
					[vim.diagnostic.severity.INFO] = signs.Info,
					[vim.diagnostic.severity.WARN] = signs.Warn,
					[vim.diagnostic.severity.ERROR] = signs.Error,
				},
			},
		})

		-- NOTE: gotta manually enable lsp server, otherwise they won't work even if automatic_enable is true
		-- Because automatic_enable doesn't work on neovim 0.12+ (at least that's what i've noticed)
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("ols")
		vim.lsp.enable("jsonls")
        vim.lsp.enable("clangd")
	end,
}
