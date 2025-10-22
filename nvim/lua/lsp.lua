vim.lsp.enable {
  'lua_ls',
  'jsonls',
  'clangd',
  'ts_ls',
  -- 'nil_ls', -- for nix
  'gopls',
  'basedpyright'
}

local builtin = require('telescope.builtin')


-- Temporary shim to silence the warning until all plugins update
local make_position_params = vim.lsp.util.make_position_params
vim.lsp.util.make_position_params = function(bufnr, ...)
  local params = select(1, ...)
  if type(params) == "string" then
    return make_position_params(bufnr, params)
  end
  -- Default to the first client's encoding if not provided
  local client = vim.lsp.get_clients({ bufnr = bufnr })[1]
  local encoding = client and client.offset_encoding or "utf-16"
  return make_position_params(bufnr, encoding)
end


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
    end

    map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
    map('gr', builtin.lsp_references, '[G]oto [R]eferences')
    map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', builtin.lsp_type_definitions, '[D]efinition')
    map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  end
})

vim.diagnostic.config {
  -- virtual_lines = true,
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
}
