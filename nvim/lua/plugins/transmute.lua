return {
  dir = '~/projects/transmute.nvim',
  config = function()
    require('transmute').setup()
    vim.keymap.set('v', '<leader>tf', require('transmute').transmute_from_to, { desc = '[T]ransmute [F]rom to' })

    vim.keymap.set('v', '<leader>tt', require('transmute').transmute_to, { desc = '[T]ransmute [T]o' })
  end,
}
