return {
  {
    "igorlfs/nvim-dap-view",
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
    config = function()
      vim.keymap.set('n', '<leader>dr', "<cmd>DapViewOpen<CR>", { desc = "[D]ap toggle [R]epl" })
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require('dap')

      vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

      dap.adapters['minecraft-js'] = {
        type = "executable",
        command = "node",
        args = { "C:/Users/henry/Projects/minecraft-debugger/dist/adapter.js" },
      }

      dap.listeners.before['event_output']['mc_dap'] = function(_, body)
        if body.category == "stdout" then
          vim.notify(body.output:sub(1, -3))
        end
      end

      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "[D]ap [C]ontinue" })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "[D]ap toggle [B]reakpoint" })

      vim.keymap.set('n', '<leader>dso', dap.step_over, { desc = "[D]ap [S]tep [O]ver" })
      vim.keymap.set('n', '<leader>dsi', dap.step_into, { desc = "[D]ap [S]tep [I]nto" })
      vim.keymap.set('n', '<leader>dsO', dap.step_out, { desc = "[D]ap [S]tep [O]ut" })
    end
  }
}
