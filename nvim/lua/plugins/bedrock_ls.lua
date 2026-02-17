local function start_bedrock_lsp()
  vim.lsp.start({
    name = "bedrock_ls",
    cmd = {
      "node",
      "C:/Users/henry/Projects/minecraft-bedrock-language-server/ide/vscode/lsp/server.js",
      "--stdio",
    },
    root_dir = vim.fs.root(0, {
      "manifest.json",
      "behavior_packs",
      "resource_packs",
      "BP",
      "RP",
    }),
  })
end

-- implementationProvider = {
--   documentSelector = {
--     { language = "jsonc" },
--     { language = "json" },
--     { language = "bc-mcfunction" },
--     { language = "bc-minecraft-language" }, material, geometry, variable, ect
--     { language = "bc-minecraft-molang" },material, geometry, variable, ect
--     { language = "bc-minecraft-other" },
--     { language = "bc-minecraft-project" }
--   }
-- }

vim.filetype.add({
  extension = {
    lang = "bc-minecraft-language",
    mcfunction = "bc-mcfunction",
    mcmeta = "bc-minecraft-other",      -- assumed
    mcproject = "bc-minecraft-project", -- assumed
  },
})


vim.api.nvim_create_user_command("BedrockStart", function()
  start_bedrock_lsp()
end, {})

vim.api.nvim_create_user_command("InspectLS", function()
  for _, client in pairs(vim.lsp.get_clients()) do
    if client.name == "bedrock_ls" then
      print(vim.inspect(client.server_capabilities))
    end
  end
end, {})

vim.api.nvim_create_user_command("InspectFRD", function()
  print("filetype:", vim.bo.filetype)
  print("root:", vim.fs.root(0, {
    "behavior_packs",
    "resource_packs",
  }))
  print("diagnostics:", vim.inspect(vim.diagnostic.get(0)))
end, {})

vim.api.nvim_create_user_command("InspectAll", function()
  print("filetype:", vim.bo.filetype)
  print("root:", vim.fs.root(0, { "manifest.json" }))

  for _, client in pairs(vim.lsp.get_clients()) do
    if client.name == "bedrock_ls" then
      print(vim.inspect(client.server_capabilities))
    end
  end

  print("diagnostics:", vim.inspect(vim.diagnostic.get(0)))
end, {})

local function bc_cmd(cmd, args)
  vim.lsp.buf.execute_command({
    command = cmd,
    arguments = args or {}
  })
end

vim.keymap.set("n", "<leader>md", function()
  bc_cmd("bc.minecraft.diagnose.project")
end)

vim.keymap.set("n", "<leader>ms", function()
  bc_cmd("bc.minecraft.project.scan")
end)

vim.keymap.set("n", "<leader>mw", function()
  bc_cmd("bc.minecraft.project.store")
end)

vim.keymap.set("n", "<leader>ma", function()
  bc_cmd("bc-files-append")
end)

return {}
