--npm install -g typescript typescript-language-server or aur it
require 'lspconfig'.tsserver.setup {
	cmd = {'typescript-language-server', '--stdio'},
	filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
	root_dir = function() return vim.loop.cwd() end -- run lsp for javascript in any directory

}

