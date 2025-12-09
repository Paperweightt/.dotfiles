if vim.g.neovide then
  local display_mode = false
  -- local default_font = 'JetBrainsMono Nerd Font:h11'
  -- local display_font = 'JetBrainsMono Nerd Font:h15.5'
  local default_font = 'FiraCode Nerd Font Mono:h11'
  -- local default_font = 'FiraCode Nerd Font Mono:h5'
  local display_font = 'FiraCode Nerd Font Mono:h15.5'

  vim.g.neovide_opacity = 0
  vim.g.neovide_transparency = 0.80
  vim.g.neovide_cursor_animation_length = 0.015
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_scale_factor = 1
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
  end, { desc = '[T]oggle [d]isplay mode' })
end
