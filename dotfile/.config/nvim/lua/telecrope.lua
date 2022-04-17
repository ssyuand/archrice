require('telescope').setup {
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		prompt_prefix = " ",
		selection_caret = " ",
		entry_prefix = "  ",
		borderchars = { '─', '│', '─', '│', '┼', '┼', '┼', '┼' },
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
	},
	extensions = {}
}

--Allow insert the search_dirs first
_G.open_telescope = function()
	Dir = vim.fn.input("Dir is: ", "~/")
	require("telescope.builtin").find_files({ search_dirs = { Dir }, hidden = true })
end

vim.api.nvim_set_keymap('n', '<leader>ff', ':lua open_telescope()<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>fw', ':Telescope grep_string<CR>', { noremap = true, silent = false }) -- need ripgrep!!!

--compile...
_G.compile = function()
	Option = vim.fn.input("do u want use less? (y/n):")
	if vim.bo.filetype == "c" or vim.bo.filetype == "cpp" then
		if Option == "n" then
			vim.cmd([[exec 'silent !g++ -o a.out %']])
			vim.cmd([[exec "silent !alacritty -e bash -c './a.out'"]])
			vim.cmd([[exec 'silent !rm a.out']])
		elseif Option == "y" then
			vim.cmd([[exec 'silent !g++ -o a.out %']])
			vim.cmd([[exec "silent !alacritty -e bash -c './a.out | less' && bash"]])
			vim.cmd([[exec 'silent !rm a.out']])
		end
	elseif vim.bo.filetype == "java" then
		if Option == "n" then
			vim.cmd([[exec 'silent !javac %']])
			vim.cmd([[exec "silent !alacritty -e bash -c 'java % && exit'"]])
		elseif Option == "y" then
			vim.cmd([[exec 'silent !javac %']])
			vim.cmd([[exec "silent !alacritty -e bash -c 'java % | less && exit'"]])
		end
	end
end
vim.api.nvim_set_keymap('n', '<leader>cc', ':lua compile()<cr>', { noremap = true, silent = true })
