---@brief
---
--- https://github.com/Blockception/minecraft-bedrock-language-server/tree/main
---
--- minecraft language server.
---
--- `minecraft-bedrock-language-server` can be installed by following the instructions [here](https://github.com/Blockception/minecraft-bedrock-language-server/tree/main?tab=readme-ov-file#getting-started).
---
--- the second parameter of `cmd` should be changed to wherever you have the
--- `minecraft-bedrock-language-server` server.js located after building it
---

vim.filetype.add({
  extension = {
    lang = "bc-minecraft-language",         -- works perfectly
    mcfunction = "bc-mcfunction",           -- has issues with blink.cmp
    mcattributes = "bc-minecraft-project",  -- untested
    molang = "bc-minecraft-molang",         -- untested
    mcignore = "bc-minecraft-project",      -- untested
    mcdefinitions = "bc-minecraft-project", --untested
  },
})

return {
  name = "bedrock_ls",
  cmd = {
    "node",
    "C:/Users/henry/Projects/minecraft-bedrock-language-server/ide/vscode/lsp/server.js",
    "--stdio",
  },
  filetypes = {
    "bc-minecraft-language",
    "bc-mcfunction",
    "bc-minecraft-project",
    "bc-minecraft-molang",
    "bc-minecraft-project",
    "bc-minecraft-project",
  },
  root_markers = { "manifest.json", ".git" }
}
