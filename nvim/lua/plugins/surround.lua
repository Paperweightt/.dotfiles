-- unmap substitute
vim.keymap.set('n', 's', '', { desc = '' })

return {
  'echasnovski/mini.surround',
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
      -- post = function(_, action) -- maybe one day
      --   if action == "add" or action == "delete" or action == "replace" then
      --     -- Using conform.nvim
      --     vim.notify("we did a thing")
      --     require("conform").format({ async = true })
      --   end
      -- end
    })
  end
}
