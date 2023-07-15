local luasnip = require 'luasnip'
local lspkind = require('lspkind')
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
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
    })
  },
  window = {
	documentation = cmp.config.window.bordered(),
	completion = cmp.config.window.bordered(),
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
