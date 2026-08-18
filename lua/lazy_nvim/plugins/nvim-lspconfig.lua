return {
	"neovim/nvim-lspconfig",
	-- lazy load on buffer read or new buffer/file open
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
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

		-- custom lsp config for server
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						checkThirdParty = false,
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		vim.lsp.enable("lua_ls")
	end,
}
