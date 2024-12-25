local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('saadparwaiz1/cmp_luasnip')
Plug('onsails/lspkind.nvim')
Plug('L3MON4D3/LuaSnip')
Plug('p00f/clangd_extensions.nvim')
Plug('nvim-treesitter/nvim-treesitter')
Plug('briones-gabriel/darcula-solid.nvim')
Plug('rktjmp/lush.nvim')
Plug('joshdick/onedark.vim')
Plug('lervag/vimtex')

vim.call('plug#end')

