
require('plugins')

vim.api.nvim_exec(
[[
syntax on

set number
highlight LineNr ctermfg=darkgrey

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

set signcolumn=number
let g:airline_theme='lucius'
]],
false)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', "<cmd>TroubleToggle<cr>", opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end


local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['hls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require('lspconfig')['quick_lint_js'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require('clangd_extensions').setup()
require('lspconfig')['pylsp'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

require('lspconfig')['yamlls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}
require('lspconfig')['bashls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = false,
    float = {
        show_header = true,
        source = 'if_many',
        border = 'rounded',
        focusable = false,
    },
    update_in_insert = true, -- default to false
    severity_sort = false, -- default to false
})

vim.api.nvim_exec([[ autocmd InsertEnter * :lua vim.diagnostic.config({virtual_text = true}) ]], false)
vim.api.nvim_exec([[ autocmd InsertLeave * :lua vim.diagnostic.config({virtual_text = false}) ]], false)
vim.api.nvim_exec([[ autocmd CursorMoved * :lua vim.diagnostic.open_float({ silent=true }) ]], false)

vim.api.nvim_set_hl(0, 'FloatBorder', {bg='None', fg='#FFFFFF'})
vim.api.nvim_set_hl(0, 'NormalFloat', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'TelescopeNormal', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'TelescopeBorder', {bg='#3B4252'})

local luasnip = require 'luasnip'

local lspkind = require('lspkind')

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    })
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
}

local api = require('cmp.utils.api')
local types = require('cmp.types')
local highlight = require('cmp.utils.highlight')
local autocmd = require('cmp.utils.autocmd')

vim.api.nvim_set_hl(0, 'CmpItemAbbr', { link = 'CmpItemAbbrDefault', default = true })
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { link = 'CmpItemAbbrDeprecatedDefault', default = true })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { link = 'CmpItemAbbrMatchDefault', default = true })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpItemAbbrMatchFuzzyDefault', default = true })
vim.api.nvim_set_hl(0, 'CmpItemKind', { link = 'CmpItemKindDefault', default = true })
vim.api.nvim_set_hl(0, 'CmpItemMenu', { link = 'CmpItemMenuDefault', default = true })
for kind in pairs(types.lsp.CompletionItemKind) do
  if type(kind) == 'string' then
    local name = ('CmpItemKind%s'):format(kind)
    vim.api.nvim_set_hl(0, name, { link = ('%sDefault'):format(name), default = true })
  end
end

autocmd.subscribe('ColorScheme', function()
  highlight.inherit('CmpItemAbbrDefault', 'Pmenu', { bg = 'NONE', default = false })
  highlight.inherit('CmpItemAbbrDeprecatedDefault', 'Comment', { bg = 'NONE', default = false })
  highlight.inherit('CmpItemAbbrMatchDefault', 'Pmenu', { bg = 'NONE', default = false })
  highlight.inherit('CmpItemAbbrMatchFuzzyDefault', 'Pmenu', { bg = 'NONE', default = false })
  highlight.inherit('CmpItemKindDefault', 'Special', { bg = 'NONE', default = false })
  highlight.inherit('CmpItemMenuDefault', 'Pmenu', { bg = 'NONE', default = false })
  for name in pairs(types.lsp.CompletionItemKind) do
    if type(name) == 'string' then
      vim.api.nvim_set_hl(0, ('CmpItemKind%sDefault'):format(name), { link = 'CmpItemKind', default = false })
    end
  end
end)
autocmd.emit('ColorScheme')


vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = true,
  }
)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
