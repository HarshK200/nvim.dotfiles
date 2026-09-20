return {
	"mfussenegger/nvim-dap",
	-- lazy load on key press
	keys = { "<leader>b", "<F5>" },
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
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

		-- setup nvim dap view
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
		-- Change breakpoint icons NOTE: make sure you have nerd font insalled
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

		-- INFO: automatically opens/close the UI when the debugger starts
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	end,
}
