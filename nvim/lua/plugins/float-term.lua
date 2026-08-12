local uname = vim.loop.os_uname().sysname

if uname == "Windows_NT" then
  vim.o.shell = 'pwsh'
  vim.o.shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command'
  vim.o.shellquote = '"'
  vim.o.shellxquote = ''
  vim.o.shellpipe = '| Out-File -Encoding UTF8 -Append'
  vim.o.shellredir = '| Out-File -Encoding UTF8'
else
  vim.opt.shell = '/bin/bash'
end

local state = {
  path = nil
}

return {
  "nvzone/floaterm",
  dependencies = "nvzone/volt",
  cmd = "FloatermToggle",
  config = function()
    local floaterm = require("floaterm")
    local floaterm_state = require("floaterm.state")
    local utils = require("floaterm.utils")

    local function send_cmd(opts)
      if not floaterm_state.terminals then
        require("floaterm").open()
        require("floaterm.api").new_term(opts)
      else
        opts.cmd = type(opts.cmd) == "string" and opts.cmd or opts.cmd()
        opts.buf = opts.buf or floaterm_state.buf
        local bufdetails = utils.get_term_by_key(opts.buf)[2]

        if opts.name then
          bufdetails = utils.get_term_by_key(opts.name, "name")[2]
        end

        local job_id = vim.b[bufdetails.buf].terminal_job_id
        vim.api.nvim_chan_send(job_id, opts.cmd)
      end
    end

    floaterm.setup({
      size = { h = 80, w = 90 },
      mappings = { sidebar = nil, term = nil },
      terminals = {
        { name = "Main" },
        { name = "Build" },
        { name = "Opencode" }
      },
    })

    vim.keymap.set('n', '<C-t>', function()
      state.path = vim.fn.expand '%:p:h'
      floaterm.toggle()
    end
    , { desc = '[T]oggle Terminal' })

    vim.keymap.set('t', '<C-t>', floaterm.toggle, { desc = '[T]oggle Terminal' })

    vim.keymap.set('t', '<C-p>', function()
      local path = state.path
      local prefix = 'oil'

      if not path then return end

      if string.sub(path, 1, #prefix) == prefix then
        path = 'C:' .. string.sub(path, 9)
      end

      send_cmd({ cmd = 'cd "' .. path .. '"\r' })
    end, { noremap = true, silent = true })
  end
}
