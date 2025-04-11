return {
  'echasnovski/mini.files',
  version = false,

  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  vim.keymap.set('n', '<leader>f', function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
    -- CdToBufferDirectory()
  end, { desc = 'Open mini-files' }),

  config = function()
    require('mini.files').setup()
  end,
}
