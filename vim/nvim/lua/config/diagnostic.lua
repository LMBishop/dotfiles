vim.diagnostic.config({
    underline = true,
    signs = true,
    virtual_text = false,
    float = {
        show_header = true,
        source = 'if_many',
        focusable = false,
        transparent = true,
    },
    update_in_insert = true, -- default to false
    severity_sort = false, -- default to false
})

vim.api.nvim_exec([[ autocmd InsertEnter * :lua vim.diagnostic.config({virtual_text = true}) ]], false)
vim.api.nvim_exec([[ autocmd InsertLeave * :lua vim.diagnostic.config({virtual_text = false}) ]], false)
vim.api.nvim_exec([[ autocmd CursorMoved * :lua vim.diagnostic.open_float({ silent=true }) ]], false)

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
