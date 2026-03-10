return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  {
    "liadOz/nvim-dap-repl-highlights",
    config = function()
      require('nvim-dap-repl-highlights').setup()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'dap_repl',
          'bash',
          'rust',
          'c',
          'html',
          'css',
          'lua',
          'powershell',
          'markdown_inline',
          'markdown',
          'jsdoc',
          'javascript',
          'gitignore',
          'yaml',
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = { enable = true },
      }
    end
  },
  {
    "igorlfs/nvim-dap-view",
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
    config = function()
      vim.keymap.set('n', '<leader>dr', "<cmd>DapViewOpen<CR>", { desc = "[D]ap open [R]epl" })
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require('dap')
      local repl = require('dap.repl')

      vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

      repl.commands = vim.tbl_extend('force', repl.commands, {
        custom_commands = {
          ['.reload'] = function()
            local session = assert(require("dap").session(), "has active session")
            session:request("sendMinecraftCommand", { command = "reload" })
          end,
          ['.run'] = function(text)
            local session = assert(require("dap").session(), "has active session")
            session:request("sendMinecraftCommand", { command = text })
          end,
        },
      })

      dap.adapters['minecraft-js'] = function(callback)
        callback({
          type = "executable",
          command = "node",
          args = { "C:/Users/henry/Projects/minecraft-debugger/dist/adapter.js" },
          options = { cwd = vim.fn.getcwd() },
        })
      end

      dap.listeners.before['event_output']['mc_dap'] = function(_, body)
        if body.output:match("\n$") then
          body.output = body.output:sub(1, -2)
        end

        if body.category == "stderr" then
          vim.notify(body.output, vim.log.levels.ERROR)
        end
      end

      vim.keymap.set('n', '<leader>mr', function()
        local session = assert(require("dap").session(), "has active session")
        session:request("sendMinecraftCommand", { command = "reload" })
      end, { desc = "[M]inecraft [R]eload" })

      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "[D]ap [C]ontinue" })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "[D]ap toggle [B]reakpoint" })

      vim.keymap.set('n', '<leader>dso', dap.step_over, { desc = "[D]ap [S]tep [O]ver" })
      vim.keymap.set('n', '<leader>dsi', dap.step_into, { desc = "[D]ap [S]tep [I]nto" })
      vim.keymap.set('n', '<leader>dsO', dap.step_out, { desc = "[D]ap [S]tep [O]ut" })
    end
  }
}
