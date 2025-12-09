return {
  {
    "XXiaoA/atone.nvim",
    cmd = "Atone",
    opts = {},

    config = function()
      require("atone").setup({
        auto_attach = {
          enabled = false
        }
      })

      local opts = { noremap = true, silent = true, desc = "[U]ndo tree toggle" }
      vim.keymap.set("n", "<Leader>u", ":Atone toggle <CR>", opts)
    end

  }
}
