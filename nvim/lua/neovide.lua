if vim.g.neovide then
  local display_mode = false
  local transparent = true
  local default_font = 'FiraCode Nerd Font Mono:h10.5'
  local display_font = 'FiraCode Nerd Font Mono:h15.5'

  vim.g.neovide_opacity = 0.90
  vim.g.neovide_cursor_animation_length = 0.045
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_scroll_animation_length = 0.35
  vim.o.guifont = default_font

  vim.api.nvim_create_user_command("Restart", function()
    vim.fn.jobstart("neovide")
    vim.cmd("qa!")
  end, {})

  vim.keymap.set('n', '<leader>td', function()
    if display_mode then
      display_mode = false
      vim.o.guifont = default_font
    else
      display_mode = true
      vim.o.guifont = display_font
    end
  end, { desc = '[T]oggle [D]isplay mode' })

  vim.keymap.set('n', '<leader>tt', function()
    if transparent then
      transparent = false
      vim.g.neovide_opacity = 1.00
    else
      transparent = true
      vim.g.neovide_opacity = 0.80
    end
  end, { desc = '[T]oggle [T]ransparency mode' })
end
