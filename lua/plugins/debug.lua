return {
	"mfussenegger/nvim-dap",
    -- lazy load on keybind press
	keys = {
		{ "<leader>b", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
		{ "<F5>", "<cmd>DapContinue<cr>", desc = "Toggle breakpoint" },
	},
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- required by dap-ui
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
		dap.adapters.codelldb = {
			type = "executable",
			command = "C:\\Program Files\\LLVM\\bin\\lldb-dap.exe",
			args = {},
		}

		-- keymaps
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
		vim.keymap.set("n", "<F5>", dap.continue)
		vim.keymap.set("n", "<F10>", dap.step_over)
		vim.keymap.set("n", "<F11>", dap.step_into)
		vim.keymap.set("n", "<F12>", dap.step_out)

		-- setup dapui
		local dapui = require("dapui")
		dapui.setup({
			icons = { expanded = "", collapsed = "", current_frame = "" },
			controls = {
				icons = {
					pause = "",
					play = "",
					step_into = "󰿄",
					step_over = "",
					step_out = "",
					step_back = "",
					run_last = "▶▶",
					terminate = "",
					disconnect = "",
				},
			},
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.5 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{
							id = "repl",
							size = 0.75,
						},
						{
							id = "console",
							size = 0.25,
						},
					},
					position = "bottom",
					size = 20,
				},
			},
		})
		-- automatically opens/close the UI when the debugger starts
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	end,
}
