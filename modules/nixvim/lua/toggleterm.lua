local Terminal = require("toggleterm.terminal").Terminal

require("toggleterm").setup({
	vim.api.nvim_set_keymap(
		"n",
		"<leader>f",
		"<cmd>lua floating_term_toggle()<CR>",
		{ noremap = true, silent = true }
	),

	vim.api.nvim_set_keymap(
		"n",
		"<leader>m",
		"<cmd>lua qalculate_toggle()<CR>",
		{ noremap = true, silent = true }
	),

	vim.api.nvim_set_keymap(
		"n",
		"<leader>g",
		"<cmd>lua lazygit_toggle()<CR>",
		{ noremap = true, silent = true }
	),
})

local floating_term = Terminal:new({
	-- FIXME: this needs to be set to a nix store path
	cmd = "fish",
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

local qalculate = Terminal:new({
	-- FIXME: this needs to be set to a nix store path
	cmd = "qalc",
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

local lazygit = Terminal:new({
	cmd = "lazygit",
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

function floating_term_toggle()
	floating_term:toggle()
end

function qalculate_toggle()
	qalculate:toggle()
end

function lazygit_toggle()
	lazygit:toggle()
end

return {
	floating_term_toggle = floating_term_toggle,
	qalculate_toggle = qalculate_toggle,
	lazygit_toggle = lazygit_toggle,
}
