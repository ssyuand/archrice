local g = vim.g
local o = vim.opt
local bo = vim.bo
local wo = vim.wo
o.scrolloff = 5
o.fileencodings = "ucs-bom,utf-8,gbk,big5,latin1"
o.encoding = "utf-8"
o.fileencoding = "utf-8"
wo.number = true --Show number
wo.relativenumber = true --Relative number
o.pumheight = 10 -- limit autocomple candidates
o.undofile = true --undofile
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.title = true --Show title in GUI
o.cmdheight = 1 -- better display for messages
o.termguicolors = true --Ture color
o.errorbells = true --Close warning bell
o.ignorecase = true --Regardless Upperlowercase
o.showmode = false --No show mode
bo.swapfile = false --No swap file
o.backup = false --No backup
wo.wrap = false --No wrap
o.incsearch = true --Show search
o.smartindent = true --smartindent
o.hidden = true --Save buffer
o.tabstop = 4 --Tab stop
o.shiftwidth = 4 --Shift width
wo.signcolumn = 'yes' --show signcolumn
o.expandtab = true --tab is 4 space
o.laststatus = 3 --Global Statusline
o.cursorline = true
vim.opt.mouse = 'a'
-- For dark/light theme (neovim's default)
vim.o.background = "dark"
-- For signColumn
vim.g.vscode_transparent = 1
-- Enable italic comment
vim.g.vscode_italic_comment = 1
-- Disable nvim-tree background color
vim.g.vscode_disable_nvimtree_bg = false
vim.cmd([[colorscheme vscode]])

--webicon
require 'nvim-web-devicons'.setup { default = true; }

-- autocomment
require 'nvim_comment'.setup()

-- no auto-comment
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")
-- hide "~"
vim.cmd([[set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾]]);
-- signColumn color
vim.cmd([[hi SignColumn guibg=NONE guifg=#011627]])
-- signColumn number
vim.cmd([[hi LineNr guifg=#011627 ]])
vim.cmd([[hi CursorLineNr guifg=#FFc0CB ]])
-- CursorLine
vim.cmd([[hi CursorLine guibg=NONE guifg=NONE]]);
-- border
vim.cmd([[hi VertSplit guibg=NONE guifg = white]]);
-- background
vim.cmd([[hi Normal guibg=NONE]]);

--Mapping
g.mapleader = ';'

local key_map = function(mode, key, result)
    vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
end
key_map('n', ';', ':') --Let (; = :)
key_map('v', '<C-c>', '"+y') --need install xclip
key_map('v', 'p', '"_dP') --paste a line without copying it
vim.keymap.set({ 'n', 'v' }, 'x', '"_x', { noremap = true, silent = false }) --Deleting a line without copying it
vim.keymap.set({ 'n', 'v' }, 'X', '"_dd', { noremap = true, silent = false }) --Deleting a line without copying it
key_map('n', '<S-j>', ':m .+1<CR>==') -- Moving lines down
key_map('n', '<S-k>', ':m .-2<CR>==') -- Moving lines up
key_map('v', '<S-j>', ":m '>+1<CR>gv=gv") -- Moving block up
key_map('v', '<S-k>', ":m '<-2<CR>gv=gv") -- Moving block down
