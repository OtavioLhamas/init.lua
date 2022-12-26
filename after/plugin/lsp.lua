local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'rust_analyzer',
  'omnisharp',
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

-- omnisharp lsp config
lsp.configure('omnisharp', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function (_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  cmd = { 'C:\\Users\\otaviolhamas\\Downloads\\omnisharp-win-x64\\OmniSharp.exe', "--languageserver" , "--hostPID", tostring(pid) },
})

lsp.on_attach(function(client, bufnr)

  if client.name == "eslint" then
      vim.cmd.LspStop('eslint')
      return
  end

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, remap = false, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('K', vim.lsp.buf.hover, '')
  nmap('<leader>vws', vim.lsp.buf.workspace_symbol, '')
  nmap('<leader>vd', vim.diagnostic.open_float, '')
  nmap('[d', vim.diagnostic.goto_next, '')
  nmap(']d', vim.diagnostic.goto_prev, '')
  nmap('<leader>vca', vim.lsp.buf.code_action, '')
  nmap('<leader>vrr', vim.lsp.buf.references, '')
  nmap('<leader>vrn', vim.lsp.buf.rename, '')
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
