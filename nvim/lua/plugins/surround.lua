-- unmap substitute
vim.keymap.set('n', 's', '', { desc = '' })

return {
  'paperweightt/mini.surround',
  version = '*',
  config = function()
    require('mini.surround').setup({
      mappings = {
        add = 'sa',            -- Add surrounding
        delete = 'sd',         -- Delete surrounding
        find = 'sf',           -- Find surrounding
        find_left = 'sF',      -- Find surrounding (left)
        highlight = 'sh',      -- Highlight surrounding
        replace = 'sr',        -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`
      },
      silent = true,
      post = function()
        require("conform").format({ async = true })
      end
    })
  end
}
