set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'mfussenegger/nvim-lint'
Plug 'airblade/vim-gitgutter'

call plug#end()

