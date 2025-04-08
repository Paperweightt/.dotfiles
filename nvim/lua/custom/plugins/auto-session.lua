-- local session_dir = vim.fn.stdpath 'data' .. '/sessions'
-- vim.fn.mkdir(session_dir, 'p')
--
-- local function get_session_name()
--   local cwd = vim.fn.getcwd()
--   return session_dir .. '/' .. cwd:gsub('[/\\]', '%%') .. '.vim'
-- end
--
-- local function save_session()
--   local session_file = get_session_name()
--   vim.cmd('mks! ' .. vim.fn.fnameescape(session_file))
-- end
--
-- local function load_session()
--   if vim.fn.argc() == 0 then -- 🧠 Only load if no file is passed on startup
--     local session_file = get_session_name()
--     if vim.fn.filereadable(session_file) == 1 then
--       vim.cmd('silent source ' .. vim.fn.fnameescape(session_file))
--     end
--   end
-- end
--
-- vim.api.nvim_create_autocmd('VimLeavePre', {
--   callback = save_session,
-- })
--
-- vim.api.nvim_create_autocmd('VimEnter', {
--   callback = load_session,
-- })
--
-- vim.api.nvim_create_user_command('SaveSession', save_session, {})
--return {}

return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    auto_restore_last_session = true,
    auto_save = true,
  },
  -- require('auto-session').setup {
  --   auto_restore_last_session = true,
  -- },
}
