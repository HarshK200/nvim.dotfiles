return {
	"karb94/neoscroll.nvim",
	config = function()
		local neoscroll = require("neoscroll")
		neoscroll.setup({
			cursor_scrolls_alone = true,
			respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
			easing = "sine",
            mappings = {}
		})
		local keymap = {
			["<C-u>"] = function()
				neoscroll.ctrl_u({ duration = 250 })
			end,
			["<C-d>"] = function()
				neoscroll.ctrl_d({ duration = 250 })
			end,
			["zt"] = function()
				neoscroll.zt({ half_win_duration = 250 })
			end,
			["zz"] = function()
				neoscroll.zz({ half_win_duration = 250 })
			end,
			["zb"] = function()
				neoscroll.zb({ half_win_duration = 250 })
			end,
		}
		local modes = { "n", "v", "x" }
		for key, func in pairs(keymap) do
			vim.keymap.set(modes, key, func)
		end
	end,
}
