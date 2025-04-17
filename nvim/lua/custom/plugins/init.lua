-- vim.o.sessionptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoions'
vim.o.scrolloff = 12
vim.o.cursorline = true
vim.o.wrap = true
vim.o.relativenumber = true

vim.o.swapfile = false

-- fold
vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'

-- tabbing
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Number of spaces for each indentation level
vim.opt.tabstop = 4 -- Number of spaces per tab
vim.opt.softtabstop = 4 -- Makes backspace delete like a tab

-- visuals
vim.o.laststatus = 0
vim.o.fillchars = 'eob: '

-- terminal
vim.o.shell = 'powershell'
vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
vim.o.shellquote = '"'
vim.o.shellxquote = ''
vim.o.shellpipe = '| Out-File -Encoding UTF8 -Append'
vim.o.shellredir = '| Out-File -Encoding UTF8'

function CdToBufferDirectory()
  local current_buffer_path = vim.fn.expand '%:p:h'
  vim.cmd('cd ' .. current_buffer_path)
end

-- vim.cmd 'autocmd VimEnter* normal! ahi'

-- remaps
--  esc to clear highlights
vim.api.nvim_set_keymap('n', '<Esc>', ':nohlsearch<Bar>echo<CR>', { noremap = true, silent = true })

-- Ctrl+S to save the file
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', function()
  vim.cmd 'w'
end, { noremap = true, silent = true })

-- Map a keybind to execute CdToBufferDirectory command
vim.keymap.set('n', '<leader>cd', CdToBufferDirectory, {
  noremap = true,
  silent = true,
  desc = '[C]d to current [D]irectory',
})

vim.keymap.set('v', '<leader>r', function()
  -- Get the selected text
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'x', false)

  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  -- Extract the selected text
  local selected_text
  if #lines == 1 then
    -- Single-line selection
    selected_text = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Multi-line selection
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
    selected_text = table.concat(lines, '\n')
  end

  -- Print or process the selected text
  print(selected_text)

  -- Prompt for replacement text
  local replacement = vim.fn.input('Replace"' .. selected_text .. '" with? ')
  if replacement ~= '' then
    -- Execute the substitution
    vim.cmd('%s/\\V' .. vim.fn.escape(selected_text, '\\') .. '/' .. vim.fn.escape(replacement, '\\') .. '/g')
  end
end, {
  desc = '[R]eplace visual selection',
})

return {}
