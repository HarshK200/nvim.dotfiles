local M = {
	previous_cmd = nil,
	terminal_buf = nil,
	terminal_win = nil,
}

local function execute_task(cmd)
	M.previous_cmd = cmd

	local origin_win = vim.api.nvim_get_current_win()

	-- Check if the terminal window is still open and valid
	if M.terminal_win and vim.api.nvim_win_is_valid(M.terminal_win) then
		-- Jump to the existing terminal window
		vim.api.nvim_set_current_win(M.terminal_win)
	else
		-- Open a new vertical split and track its window ID
		vim.cmd("vsplit")
		M.terminal_win = vim.api.nvim_get_current_win()
	end

	-- Execute the terminal command
	vim.cmd("terminal " .. cmd)
	M.terminal_buf = vim.api.nvim_get_current_buf()

	-- Jump back to your original window without moving your cursor
	if vim.api.nvim_win_is_valid(origin_win) then
		vim.api.nvim_set_current_win(origin_win)
	end
end

function M.spawn_task()
	-- Check if Telescope is installed at runtime
	local has_telescope, pickers = pcall(require, "telescope.pickers")
	if not has_telescope then
		vim.notify("nvim-tasks: telescope.nvim is required for this plugin", vim.log.levels.ERROR)
		return
	end

	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	-- get tasks filepath
	local json_file = vim.fs.joinpath(vim.fn.getcwd(), "nvim-tasks.json")

	-- read tasks file
	if vim.fn.filereadable(json_file) == 0 then
		vim.notify("ERROR: nvim-tasks.json not found", vim.log.levels.ERROR)
		return
	end
	local file = io.open(json_file, "r")
	if not file then
		vim.notify("ERROR: Failed to read nvim-tasks.json", vim.log.levels.ERROR)
		return
	end
	local content = file:read("*a")
	file:close()

	-- decode json file
	local success, tasks = pcall(vim.json.decode, content)
	if not success or type(tasks) ~= "table" then
		vim.notify("ERROR: Failed to parse nvim-tasks.json", vim.log.levels.ERROR)
		return
	end

	-- open telescope for picking
	pickers
		.new({
			layout_strategy = "horizontal",
			sorting_strategy = "ascending",
			previewer = false,
			layout_config = {
				height = 0.4,
				width = 0.4,
				anchor = "N", -- keeps the whole telescope window at the top
				horizontal = {
					prompt_position = "top", -- Keeps the text prompt at the top of that window
				},
			},
		}, {
			prompt_title = "Select Task to Spawn",
			finder = finders.new_table({
				results = tasks,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.label,
						ordinal = entry.label .. " " .. (entry.cmd or ""),
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						M.previous_cmd = selection.value.cmd
						execute_task(selection.value.cmd)
						-- vim.cmd("vsplit | terminal " .. selection.value.cmd)
					else
						vim.notify("WARN: no entry selected", vim.log.levels.WARN)
					end
				end)
				return true
			end,
		})
		:find()
end

function M.run_previous_task()
	if not M.previous_cmd then
		vim.notify("WARN: no previous command", vim.log.levels.WARN)
		return
	end

	execute_task(M.previous_cmd)
end

function M.setup(_)
	vim.api.nvim_create_user_command("Spawn", M.spawn_task, {})
	vim.keymap.set("n", "<M-t>", M.run_previous_task)
end

return M
