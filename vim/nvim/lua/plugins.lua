return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'neovim/nvim-lspconfig'
  use {'quick-lint/quick-lint-js', rtp = 'plugin/vim/quick-lint-js.vim', tag = '2.10.0', opt = true}
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'onsails/lspkind.nvim'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use "p00f/clangd_extensions.nvim"
end)
