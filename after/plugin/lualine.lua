local winbar_filetype_exclude = {
  'help',
  'startify',
  'dashboard',
  'lazy',
  'neo-tree',
  'neogitstatus',
  'NvimTree',
  'Trouble',
  'alpha',
  'lir',
  'Outline',
  'spectre_panel',
  'toggleterm',
  'DressingSelect',
  'Jaq',
  'harpoon',
  'dap-repl',
  'dap-terminal',
  'dapui_console',
  'dapui_hover',
  'lab',
  'notify',
  'noice',
  'neotest-summary',
  '',
}

local navic_opts = {
  icons = {
    [1] = ' ', -- File
    [2] = ' ', -- Module
    [3] = ' ', -- Namespace
    [4] = ' ', -- Package
    [5] = ' ', -- Class
    [6] = ' ', -- Method
    [7] = ' ', -- Property
    [8] = ' ', -- Field
    [9] = ' ', -- Constructor
    [10] = '練', -- Enum
    [11] = '練', -- Interface
    [12] = ' ', -- Function
    [13] = ' ', -- Variable
    [14] = ' ', -- Constant
    [15] = ' ', -- String
    [16] = ' ', -- Number
    [17] = '◩ ', -- Boolean
    [18] = ' ', -- Array
    [19] = ' ', -- Object
    [20] = ' ', -- Key
    [21] = 'ﳠ ', -- Null
    [22] = ' ', -- EnumMember
    [23] = ' ', -- Struct
    [24] = ' ', -- Event
    [25] = ' ', -- Operator
    [26] = ' ', -- TypeParameter
    [255] = ' ', -- Macro
  },
  highlight = true,
  separator = ' > ',
  depth_limit = 0,
  depth_limit_indicator = '..',
  safe_output = true,
}

require('nvim-navic').setup(navic_opts)

local get_navic = function()
  if vim.tbl_contains(winbar_filetype_exclude or {}, vim.bo.filetype) then
    return ''
  end

  local navic_ok, navic = pcall(require, 'nvim-navic')
  if not navic_ok then
    return ''
  end

  if not navic.is_available() then
    return ''
  end

  local data = navic.get_data()

  if data == nil then
    return ''
  end

  local lib = require('nvim-navic.lib')
  local t = {}
  local ret = ''

  for _, v in ipairs(data) do
    if navic_opts.highlight then
      table.insert(t, "%#NavicIcons"
        .. lib.adapt_lsp_num_to_str(v.kind)
        .. "#"
        .. navic_opts.icons[v.kind]
        .. '%*%#LineNr#'
        .. v.scope.start.line
        .. "%* %#NavicText#"
        .. v.name
        .. '%*')
    else
      table.insert(t, navic_opts.icons[v.kind] .. v.scope.start.line .. ' ' .. v.name)
    end
  end

  if navic_opts.highlight then
    ret = table.concat(t, "%#NavicSeparator#" .. navic_opts.separator .. "%*")
  else
    ret = table.concat(t, navic_opts.separator)
  end

  return ret
end

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  tabline = {
    -- lualine_a = {
    --   {
    --     'tabs',
    --     mode = 2,
    --     fmt = function(name, context)
    --       -- Show + if buffer is modified in tab
    --       local buflist = vim.fn.tabpagebuflist(context.tabnr)
    --       local winnr = vim.fn.tabpagewinnr(context.tabnr)
    --       local bufnr = buflist[winnr]
    --       local mod = vim.fn.getbufvar(bufnr, '&mod')
    --
    --       return name .. (mod == 1 and ' +' or '')
    --     end
    --   }
    -- },
  },
  winbar = {
    lualine_a = {
      {
        function()
          return get_navic()
        end,
        cond = function()
          local navic = require('nvim-navic')
          return navic.is_available()
        end,
        draw_empty = true,
        color = 'evil_lualine'
      },
    }
  }
}

require('nvim-web-devicons').setup()
