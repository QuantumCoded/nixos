local Terminal = require("toggleterm.terminal").Terminal

require("toggleterm").setup({
  vim.api.nvim_set_keymap(
		"n",
		"<leader>f",
		"<cmd>lua floating_term_toggle()<CR>",
		{ noremap = true, silent = true }
	)
})

local floating_term = Terminal:new({
	-- FIXME: this needs to be set to a nix store path
	cmd = "fish -c 'clear'",
	dir = "git_dir",
	direction = "float",
	float_opts = {},

	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(
			term.bufnr,
			"n",
			"q",
			"<cmd>close<CR>",
			{ noremap = true, silent = true }
		)
	end,

	on_close = function(term)
		vim.cmd("startinsert!")
	end
})

--[[
local qalculate = Terminal:new({
	-- TODO: this needs to be set to a nix store path
	cmd = "fish -c 'clear && qalc'",
	dir = "git_dir",
	direction = "float",
	float_opts = {},

	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(
			term.bufnr,
			"n",
			"q",
			"<cmd>close<CR>",
			{ noremap = true, silent = true }
		)
	end,

	on_close = function(term)
		vim.cmd("startinsert!")
	end
})
]]

function floating_term_toggle()
	floating_term:toggle()
end

return {
	floating_term_toggle = floating_term_toggle
}
