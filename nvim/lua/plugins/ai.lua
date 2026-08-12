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
    'milanglacier/minuet-ai.nvim',
    config = function()
      require('minuet').setup {
        provider = 'openai_fim_compatible',
        n_completions = 1,
        context_window = 512,
        provider_options = {
          openai_fim_compatible = {
            -- For Windows users, TERM may not be present in environment variables.
            -- Consider using APPDATA instead.
            api_key = 'APPDATA',
            name = 'Ollama',
            end_point = 'http://localhost:11434/v1/completions',
            model = 'qwen2.5-coder:7b',
            optional = {
              max_tokens = 56,
              top_p = 0.9,
            },
          },
        },
        virtualtext = {
          enable = true,
          auto_trigger_ft = { "*" },
          keymap = {
            -- accept whole completion
            accept = '<A-A>',
            -- accept one line
            accept_line = '<A-a>',
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = '<A-z>',
            -- Cycle to prev completion item, or manually invoke completion
            prev = '<A-[>',
            -- Cycle to next completion item, or manually invoke completion
            next = '<A-]>',
            dismiss = '<A-e>',
          },
        },
      }
    end,
  },
}
