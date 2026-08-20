---@class PresentationOptions
---@field focus boolean

---@class Task
---@field label string
---@field command string
---@field presentation PresentationOptions

---@class Tasks
---@field version string
---@field tasks Task[]

local M = {
	---@type Task|nil
	previous_task = nil,

	terminal_buf = nil,
	terminal_win = nil,
}

---Executes the task
---@param task Task
local function execute_task(task)
	local origin_win = vim.api.nvim_get_current_win()

	-- Delete previous buffer if exists
	if M.terminal_buf and vim.api.nvim_buf_is_valid(M.terminal_buf) then
		vim.api.nvim_buf_delete(M.terminal_buf, { force = true, unload = true })
	end
	-- Check if the terminal window is still open and valid
	if M.terminal_win and vim.api.nvim_win_is_valid(M.terminal_win) then
		-- close the already open window
		vim.api.nvim_win_close(M.terminal_win, true)
	end

	-- create a new buffer for jobstart to work in
	M.terminal_buf = vim.api.nvim_create_buf(false, true)
	-- Open a new horizontal split and track its window ID
	local width = math.floor(vim.o.columns / 2.5)
	local height = math.floor(vim.o.lines / 3)

	M.terminal_win = vim.api.nvim_open_win(M.terminal_buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = 0,
		col = vim.o.columns - width - 1,
		border = "rounded",
		title = " " .. task.label .. " ",
		title_pos = "left",
	})

	-- Execute the terminal command
	vim.fn.jobstart(task.command, {
		term = true,
		cwd = vim.fn.getcwd(),
		width = width,
		height = height, -- NOTE: the terminal doesn't really care about the height it covers the whole window
	})
	vim.api.nvim_win_set_cursor(M.terminal_win, {
		vim.api.nvim_buf_line_count(M.terminal_buf),
		0,
	})

	-- Jump back to your original window if focus is false
	if vim.api.nvim_win_is_valid(origin_win) and task.presentation.focus == false then
		vim.api.nvim_set_current_win(origin_win)
	end
end

function M.spawn_task()
	-- Check if Telescope is installed at runtime
	local has_telescope, pickers = pcall(require, "telescope.pickers")
	if not has_telescope then
		vim.notify("TaskSpawner: telescope.nvim is required for this plugin", vim.log.levels.ERROR)
		return
	end

	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	-- get launch.json filepath
	local json_file = vim.fs.joinpath(vim.fn.getcwd(), ".vscode", "tasks.json")

	-- read launch.json file
	if vim.fn.filereadable(json_file) == 0 then
		vim.notify("ERROR: .vscode/launch.json not found", vim.log.levels.ERROR)
		return
	end
	local file = io.open(json_file, "r")
	if not file then
		vim.notify("ERROR: Failed to read .vscode/launch.json", vim.log.levels.ERROR)
		return
	end
	local content = file:read("*a")
	file:close()

	-- decode json file
	---@type boolean, Tasks
	local success, tasks_file = pcall(vim.json.decode, content)
	if not success or type(tasks_file) ~= "table" then
		vim.notify("ERROR: Failed to parse .vscode/launch.json", vim.log.levels.ERROR)
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
				results = tasks_file["tasks"], -- following the .vscode\tasks.json schema
				---@param task Task
				entry_maker = function(task)
					return {
						value = task,
						display = task.label,
						ordinal = task.label .. " " .. (task.command or ""), -- the actual choice text shown
					}
				end,
			}),

			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						M.previous_task = selection.value
						execute_task(selection.value)
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
	if not M.previous_task then
		vim.notify("WARN: no previous command", vim.log.levels.WARN)
		return
	end

	-- get launch.json filepath
	local json_file = vim.fs.joinpath(vim.fn.getcwd(), ".vscode", "tasks.json")

	-- read launch.json file
	if vim.fn.filereadable(json_file) == 0 then
		vim.notify("ERROR: .vscode/tasks.json not found", vim.log.levels.ERROR)
		return
	end
	local file = io.open(json_file, "r")
	if not file then
		vim.notify("ERROR: Failed to read .vscode/tasks.json", vim.log.levels.ERROR)
		return
	end
	local content = file:read("*a")
	file:close()

	-- decode json file
	---@type boolean, Tasks
	local success, tasks_file = pcall(vim.json.decode, content)
	if not success or type(tasks_file) ~= "table" then
		vim.notify("ERROR: Failed to parse .vscode/tasks.json", vim.log.levels.ERROR)
		return
	end

	local task
	for _, t in ipairs(tasks_file["tasks"]) do
		if t.label == M.previous_task.label then
			task = t
		end
	end
	if not task then
		vim.notify("Error: previous task " .. M.previous_task.label .. " is not in launch.json", vim.log.levels.ERROR)
		return
	end

	execute_task(task)
end

function M.setup()
	-- create user commands
	vim.api.nvim_create_user_command("Spawn", M.spawn_task, {})
	vim.api.nvim_create_user_command("SpawnPrevious", M.run_previous_task, {})
end

return M
