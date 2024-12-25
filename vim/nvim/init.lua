require('plugins')


require('keybindings')
require('config')

vim.api.nvim_exec(
[[
silent!
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

let g:vimtex_view_method = 'zathura'
]],
false)
