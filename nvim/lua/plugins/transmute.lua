return {
  dir = '~/projects/transmute.nvim',
  config = function()
    vim.keymap.set('v', '<leader>tf', require('transmute').transmute_from_to, { desc = '[T]ransmute [F]rom to' })

    vim.keymap.set('v', '<leader>tt', require('transmute').transmute_to, { desc = '[T]ransmute [T]o' })

    vim.keymap.set('n', '<leader>rr', function()
      package.loaded['transmute'] = nil
      package.loaded['transmute.converters.colors'] = nil
      require('transmute').setup()
    end, { desc = '[R]eload transmute plugin' })
  end,
} -- #ffffff
