if vim.g.neovide then
  vim.g.neovide_opacity = 0
  vim.g.neovide_transparency = 0.80
  vim.g.neovide_cursor_animation_length = 0.015
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_scale_factor = 1
  vim.o.guifont = 'FiraCode Nerd Font Mono:h11'
  -- vim.o.guifont = 'FiraCode Nerd Font Mono:h15.5'

  local function sync_separator_with_background()
    local normal_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
    vim.api.nvim_set_hl(0, 'WinSeparator', {
      fg = '#83a598', -- your custom separator color
      bg = normal_bg and string.format('#%06x', normal_bg) or 'NONE',
    })
  end

  -- Run immediately (after colorscheme loads)
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = sync_separator_with_background,
  })

  -- Also run once at startup
  sync_separator_with_background()
end

return {}
