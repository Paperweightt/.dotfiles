local function yank_visible_buffers()
  local bufs = vim.api.nvim_list_wins()
  local all_lines = {}

  for _, win_id in ipairs(bufs) do
    local buf = vim.api.nvim_win_get_buf(win_id)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local file_name = vim.api.nvim_buf_get_name(buf)
    table.insert(all_lines, "```" .. file_name)
    vim.list_extend(all_lines, lines)
    table.insert(all_lines, "```")
  end

  vim.fn.setreg('"', table.concat(all_lines, "\n"))
  vim.fn.setreg('+', table.concat(all_lines, "\n")) -- also system clipboard (if supported)
end

-- Map y<space> in normal mode
vim.keymap.set("n", "y ", yank_visible_buffers, { desc = "Yank all visible buffers" })

return {}
