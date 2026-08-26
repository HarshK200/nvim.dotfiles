return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	-- lazy load on buffer read or new buffer/file open
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = false,
		keywords = {
			TODO = { icon = "", color = "TODO_COLOR" },
			NOTE = { icon = "", color = "NOTE_COLOR" },
		},
		gui_style = {
			fg = "BOLD,UNDERLINE",
			bg = "NONE",
		},
		merge_keywords = false,
		highlight = {
			multiline = true,
			multiline_pattern = "^.",
			multiline_context = 10,
			before = "", -- nothing before the keyword
			keyword = "fg", -- ONLY the matched keyword text itself, not "wide" (which bleeds into surrounding chars)
			after = "", -- nothing after the keyword — this is what stops the rest of the comment from being highlighted
			pattern = [[.*<(KEYWORDS)>]], -- dropped \s*: — see below
			comments_only = true,
			max_line_len = 400,
			exclude = {},
		},
		colors = {
			TODO_COLOR = { "TODO_COLOR", "#f07178" },
			NOTE_COLOR = { "NOTE_COLOR", "#98c379" },
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			pattern = [[\b(KEYWORDS)\b]], -- dropped the trailing colon here too
		},
	},
}
