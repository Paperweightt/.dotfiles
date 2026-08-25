vim.env.PATH = 'C:\\Users\\henry\\copilot;' .. vim.env.PATH

return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type for details
      }

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ") end, { desc = "Ask OpenCode…" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Select OpenCode…" })
      vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
        { desc = "Append range to OpenCode", expr = true })
      vim.keymap.set({ "n" }, "goo", function() return require("opencode").operator("@this ") .. "_" end,
        { desc = "Append line to OpenCode", expr = true })
      vim.keymap.set({ "n" }, "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
        { desc = "Scroll OpenCode up" })
      vim.keymap.set({ "n" }, "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
        { desc = "Scroll OpenCode down" })
    end,
  },
  {
    "copilotlsp-nvim/copilot-lsp",
    init = function()
      vim.g.copilot_nes_debounce = 500
      vim.lsp.enable("copilot_ls")
      vim.keymap.set("n", "<tab>", function()
        local bufnr = vim.api.nvim_get_current_buf()
        local state = vim.b[bufnr].nes_state
        if state then
          -- Try to jump to the start of the suggestion edit.
          -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
          local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
              or (
                require("copilot-lsp.nes").apply_pending_nes()
                and require("copilot-lsp.nes").walk_cursor_end_edit()
              )
          return nil
        else
          -- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
          return "<C-i>"
        end
      end, { desc = "Accept Copilot NES suggestion", expr = true })
    end,
  }
}
