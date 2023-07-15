require('plugins')

vim.api.nvim_exec(
[[
syntax on

set number
highlight LineNr ctermfg=darkgrey
highlight NormalFloat ctermbg=NONE

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

set signcolumn=number
let g:airline_theme='lucius'
set termguicolors
colorscheme onedark
highlight Normal guibg=NONE
highlight Comment cterm=italic gui=italic
]],
false)
-- 

require('keybindings')
require('config')

