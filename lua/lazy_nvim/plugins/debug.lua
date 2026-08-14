return {
	"mfussenegger/nvim-dap",
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
		dap.adapters.lldb = {
			type = "executable",
			command = "C:\\Program Files\\LLVM\\bin\\lldb-dap.exe",
			args = {},
		}

		-- keymaps
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
		vim.keymap.set("n", "<F5>", dap.continue)
		vim.keymap.set("n", "<C-F10>", dap.step_over)
		vim.keymap.set("n", "<C-F11>", dap.step_into)
		vim.keymap.set("n", "<C-F12>", dap.step_out)

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
		})
		-- automatically opens/close the UI when the debugger starts
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	end,
}
