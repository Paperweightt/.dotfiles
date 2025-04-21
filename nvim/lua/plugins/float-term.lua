local state = {
  floating = {
    buf = -1,
    win = -1,
    dir = nil,
  },
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  local dir = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
    dir = vim.fn.expand '%:p:h'
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal', -- No borders or extra UI elements
    border = 'rounded',
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win, dir = dir }
end

local resetState = function()
  state = {
    floating = {
      buf = -1,
      win = -1,
      dir = nil,
    },
  }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

local new_terminal = function()
  resetState()
  toggle_terminal()
end

local toggle_terminal_here = function()
  local current_term_path = vim.fn.expand '%:p:h'
  local prev_term_path = state.floating.dir
  local prev_path = vim.fn.getcwd()

  print(current_term_path)

  if prev_term_path and current_term_path == prev_term_path then
    print 'old term'
    toggle_terminal()
  else
    print 'new term'
    vim.cmd('cd ' .. current_term_path)
    new_terminal()
    vim.cmd('cd ' .. prev_path)
  end
end

local toggle_new_terminal_here = function()
  local current_path = vim.fn.expand '%:p:h'
  local prev_path = vim.fn.getcwd()

  vim.cmd('cd ' .. current_path)
  new_terminal()
  vim.cmd('cd ' .. prev_path)
end

vim.keymap.set('n', '<leader>to', toggle_terminal, { desc = '[T]erminal [O]pen' })
vim.keymap.set('n', '<leader>tO', new_terminal, { desc = '[T]erminal [O]pen New' })
vim.keymap.set('n', '<leader>th', toggle_terminal_here, { desc = '[T]erminal [H]ere' })
vim.keymap.set('n', '<leader>tH', toggle_new_terminal_here, { desc = '[T]erminal [H]ere new' })

-- Map Ctrl-t in normal and terminal modes
vim.keymap.set('n', '<C-t>', toggle_terminal, { desc = '[T]oggle Terminal' })
vim.keymap.set('t', '<C-t>', function()
  -- Leave terminal insert mode and toggle the terminal
  vim.api.nvim_command 'stopinsert'
  toggle_terminal()
end, { desc = '[T]oggle Terminal' })

return {}
