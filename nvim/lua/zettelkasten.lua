local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")

local note_dir = 'C:/Users/henry/Notes/Zettelkasten'
local ns_link_id = vim.api.nvim_create_namespace("zettelkasten_links")
local link_hl_group = "ZKLink"

vim.api.nvim_set_hl(0, link_hl_group, {
  underline = true,
  -- fg = "#ff8800", -- optional foreground color
})

---@class Tag
---@field id string
---@field filename string
---@field location number[]  -- {line, col}

---@class Note
---@field id string
---@field filename string
---@field alias string[]
---@field location number[]  -- {line, col}

---@return Tag[]
local function get_tags()
  local cmd = 'rg --no-heading --with-filename --column --line-number -g "*.md" "#" "' .. note_dir .. '"'
  local handle = io.popen(cmd)
  if not handle then return {} end

  local results = {}
  for line in handle:lines() do
    if not line:match("##") and not line:match("# ") then
      local filename, line_num, col_num, id = line:match("^(.-):(%d+):(%d+):(.*)")

      table.insert(results, {
        filename = filename,
        id = id,
        location = { tonumber(line_num), tonumber(col_num) - 1 },
      })
    end
  end

  handle:close()

  return results
end

---@return Note[]
local function get_notes()
  local cmd = 'rg --no-heading --with-filename --column --line-number -g "*.md" "# " "' .. note_dir .. '"'
  local handle = io.popen(cmd)
  if not handle then return {} end

  local results = {}
  for line in handle:lines() do
    if not line:match("##") and line:match("# ") then
      local filename, line_num, col_num, id = line:match("^(.-):(%d+):(%d+):(.*)")

      table.insert(results, {
        filename = filename,
        id = id,
        location = { tonumber(line_num), tonumber(col_num) - 1 },
      })
    end
  end

  handle:close()

  return results
end

---@param note_id string
---@return Note
local function get_note(note_id)
  local cmd = 'rg --no-heading --with-filename --column --line-number -g "*.md" ' ..
      '"# ' .. note_id .. '" "' .. note_dir .. '"'
  local handle = io.popen(cmd)
  if not handle then return {} end

  local results = {}
  for line in handle:lines() do
    if not line:match("##") and line:match("# ") then
      local filename, line_num, col_num, id = line:match("^(.-):(%d+):(%d+):(.*)")

      return {
        filename = filename,
        id = id,
        location = { tonumber(line_num), tonumber(col_num) - 1 },
      }
    end
  end

  handle:close()

  return results
end

local function tag_search()
  pickers.new({}, {
    prompt_title = "Search Tags",
    finder = finders.new_table({
      results = get_tags(),
      entry_maker = function(entry)
        local content = entry.id
        local filename = entry.filename
        local linenum = entry.location[1]
        local tag = content:match("#%w+")

        local displayer = entry_display.create({
          separator = " │ ",
          items = {
            { width = 20 },       -- tag
            { remaining = true }, -- file and preview
          },
        })

        return {
          value = entry,
          ordinal = content,
          display = function()
            return displayer({
              tag or "[no tag]",
              string.format("%s:%s", vim.fn.fnamemodify(filename, ":t"), linenum),
            })
          end,
          filename = filename,
          lnum = tonumber(linenum),
          path = filename
        }
      end
    }),
    previewer = conf.grep_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

local function note_search()
  pickers.new({}, {
    prompt_title = "Search Notes",
    finder = finders.new_table({
      results = get_notes(),
      entry_maker = function(entry)
        local content = entry.id
        local filename = entry.filename
        local linenum = entry.location[1]
        local tag = content:match("# %w+")

        local displayer = entry_display.create({
          separator = " │ ",
          items = {
            { width = 20 },       -- tag
            { remaining = true }, -- file and preview
          },
        })

        return {
          value = entry,
          ordinal = content,
          display = function()
            return displayer({
              tag or "[no tag]",
              string.format("%s:%s", vim.fn.fnamemodify(filename, ":t"), linenum),
            })
          end,
          filename = filename,
          lnum = tonumber(linenum),
          path = filename
        }
      end
    }),
    previewer = conf.grep_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end


local function show_links(bufnr)
  local notes = get_notes()

  table.sort(notes, function(a, b)
    return #a > #b
  end)

  for _, note in pairs(notes) do
    local line_count = vim.api.nvim_buf_line_count(bufnr)

    for i = 0, line_count - 1 do
      local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]

      local start, _end = line:find(note.id:sub(3), 1, true)

      if start and _end then
        vim.api.nvim_buf_set_extmark(bufnr, ns_link_id, i, start - 1, {
          end_col = _end, hl_group = link_hl_group })
      end
    end
  end
end


---@return string | nil
local function get_link_at_cursor()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0) -- {line, col}
  local cursor_line = cursor[1] - 1
  local cursor_col = cursor[2]

  -- Get all extmarks with range and details
  local marks = vim.api.nvim_buf_get_extmarks(bufnr, ns_link_id, 0, -1, {
    details = true,
  })

  for _, mark in ipairs(marks) do
    local line, col, details = mark[2], mark[3], mark[4]
    local end_col = details.end_col or col
    local end_line = details.end_row or line

    local in_same_line = cursor_line == line and cursor_line == end_line
    local in_range = cursor_col >= col and cursor_col < end_col

    if in_same_line and in_range then
      local text = vim.api.nvim_buf_get_text(bufnr, line, col, end_line, end_col, {})
      return table.concat(text, "\n")
      -- print("Underlined text: " .. table.concat(text, "\n"))
    end
  end
end

local function goto_note()
  local note_name = get_link_at_cursor()
  if not note_name then return end
  local note = get_note(note_name)

  note.location[2] = 2

  vim.cmd("edit " .. note.filename)
  vim.api.nvim_win_set_cursor(0, note.location)
end

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
  pattern = "*.md",
  callback = function(event)
    show_links(event.buf)
  end,
})

-- local function find_note_at_cursor()
--   local word = vim.fn.expand("<cword>")
--   local entry = get_note(word)
--
--   if not entry then return end
--
--   local filepath, line_number, content = entry:match("^(.-):(%d+):(.*)")
--
--   vim.cmd("edit " .. filepath)                                 -- Opens the file
--   vim.api.nvim_win_set_cursor(0, { tonumber(line_number), 0 }) -- Moves the cursor to the line (1-based)
-- end

vim.keymap.set("n", "<leader>zn", note_search, { desc = "[N]otes Search" })
vim.keymap.set("n", "<leader>zt", tag_search, { desc = "[T]ags Search" })
vim.keymap.set("n", "gz", goto_note, { desc = "[g]oto [Z]ettelkasten Note" })
