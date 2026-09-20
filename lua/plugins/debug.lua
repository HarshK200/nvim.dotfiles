return {
	"mfussenegger/nvim-dap",
	-- lazy load on key press
	keys = { "<leader>b", "<F5>" },
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"igorlfs/nvim-dap-view",
	},
	config = function()
		-- set custom looking breakpoints, Requires Nerd Font
		vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
		vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
		local breakpoint_icons = {
			Breakpoint = "●",
			BreakpointCondition = "",
			BreakpointRejected = "⊘",
			LogPoint = "◆",
			Stopped = "",
		}
		for type, icon in pairs(breakpoint_icons) do
			local tp = "Dap" .. type
			local hl = (type == "Stopped") and "DapStop" or "DapBreak"
			vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
		end

		-- setup debug adapters
		local dap = require("dap")
		local mason_registry = require("mason-registry")

		-- c/c++ codelldb
		local codelldb_path = mason_registry.get_package("codelldb"):get_install_path()
			.. "/extension/adapter/codelldb.exe"
		dap.adapters.lldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = codelldb_path,
				args = { "--port", "${port}" },
			},
		}

		-- nvim-dap keymaps
		vim.keymap.set("n", "<leader>b", function()
			dap.toggle_breakpoint()
		end)
		vim.keymap.set("n", "<F5>", function()
			dap.continue()
		end)
		vim.keymap.set("n", "<F9>", function()
			dap.step_out()
		end)
		vim.keymap.set("n", "<F10>", function()
			dap.step_over()
		end)
		vim.keymap.set("n", "<F11>", function()
			dap.step_into()
		end)
		vim.keymap.set("n", "<F4>", function()
			dap.terminate()
		end)

		-- setup nvim dap view
		local dapview = require("dap-view")
		vim.keymap.set("n", "<leader>dv", function()
			dapview.toggle()
		end)
	end,
}
