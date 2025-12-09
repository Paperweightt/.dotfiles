return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,

  config = function() -- Default options:
    local transparent = true

    if vim.g.neovide then
      transparent = false

      local function sync_separator_with_background()
        local normal_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
        vim.api.nvim_set_hl(0, 'WinSeparator', {
          fg = '#83a598',
          bg = normal_bg and string.format('#%06x', normal_bg) or 'NONE',
        })
      end

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = sync_separator_with_background,
      })

      sync_separator_with_background()
    end

    require('gruvbox').setup {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = false,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,    -- invert background for search, diffs, statuslines and errors
      contrast = 'soft', -- can be "hard", "soft" or empty string
      palette_overrides = {
        -- bg = '#1A1A1A',
      },
      overrides = {
        Normal = { bg = '#1b1b1b' },
        SignColumn = { bg = '#1b1b1b' },
        Folded = { bg = '#1b1b1b' },
      },
      dim_inactive = false,
      transparent_mode = transparent,
    }
    vim.cmd.colorscheme 'gruvbox'
  end,
}
