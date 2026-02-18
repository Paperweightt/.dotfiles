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
    mcdefinitions = "bc-minecraft-project", -- untested
  },
})

---@type vim.lsp.Config
return {
  name = "bedrock_ls",
  cmd = {
    "node",
    "C:/Users/henry/Projects/minecraft-bedrock-language-server/ide/vscode/lsp/server.js",
    "--stdio",
  },
  filetypes = {
    "bc-mcfunction",
    "bc-minecraft-language",
    "bc-minecraft-molang",
    "bc-minecraft-project",
    "bc-minecraft-project",
    "bc-minecraft-project",
  },
  --prioritize .git so that project can include both rp and bp then fallback to manifest.json
  root_dir = vim.fs.root(0, { { ".git" }, "manifest.json" })
}
