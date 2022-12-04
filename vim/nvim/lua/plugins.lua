return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'neovim/nvim-lspconfig'
  use {'quick-lint/quick-lint-js', rtp = 'plugin/vim/quick-lint-js.vim', tag = '2.10.0', opt = true}
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp' 
  use 'saadparwaiz1/cmp_luasnip' 
  use 'onsails/lspkind.nvim'
  use 'L3MON4D3/LuaSnip' 
  use {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup {

      }
    end
  }
  use 'p00f/clangd_extensions.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use { "briones-gabriel/darcula-solid.nvim", requires = "rktjmp/lush.nvim" }
end)
