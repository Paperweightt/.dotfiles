return {
  'b0o/incline.nvim',
  config = function()
    local devicons = require 'nvim-web-devicons'
    require('incline').setup {
      window = {
        margin = {
          horizontal = 0,
        },
      },
      render = function(props)
        local path = vim.api.nvim_buf_get_name(props.buf)
        local filename

        if path == '' then
          filename = '[No Name]'
        else
          local parts = vim.split(path, '/')
          filename = table.concat({ parts[#parts - 1], parts[#parts] }, '/')
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)

        local function get_diagnostic_label()
          local icons = { error = '', warn = '', info = '', hint = '' }
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(label, { icon .. n .. ' ', group = 'DiagnosticSign' .. severity })
            end
          end
          if #label > 0 then
            table.insert(label, { '┊ ' })
          end
          return label
        end

        return {
          { get_diagnostic_label() },
          { (ft_icon or '') .. ' ', guifg = ft_color, guibg = 'none' },
          { filename, gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
        }
      end,
    }
  end,
  -- Optional: Lazy load Incline
  event = 'VeryLazy',
}
