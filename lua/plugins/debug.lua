return {
	"mfussenegger/nvim-dap",
	-- lazy load on key press
	keys = { "<leader>b", "<F5>" },
	dependencies = {
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
		dap.adapters.lldb = {
			type = "executable",
			command = "C:\\Program Files\\LLVM\\bin\\lldb-dap.exe",
			args = {},
		}

		-- keymaps
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
	end,
}
