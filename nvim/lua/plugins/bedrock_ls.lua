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

vim.filetype.add({
  extension = {
    lang = "bc-minecraft-language",
    mcfunction = "bc-mcfunction",
    mcattributes = "bc-minecraft-project",
    molang = "bc-minecraft-molang",
    mcignore = "bc-minecraft-project",
    mcdefinitions = "bc-minecraft-project",
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

local function find_root()
  local root = vim.fs.root(0, { { ".git" }, "manifest.json" })

  return root
end

vim.api.nvim_create_user_command("InspectFRD", function()
  print("filetype:", vim.bo.filetype)
  print("root:", find_root())
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

--- bedrock_ls
--- schemas are provided from
--- https://github.com/Blockception/Minecraft-bedrock-json-schemas/blob/main/docs/guide/ide_setup.md#neovim-with-lsp
local schemas = {
  -- General schemas
  {
    description = "Minecraft Bedrock Manifest",
    fileMatch = { "manifest.json", "manifest.jsonc", "manifest.json5" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/general/manifest.json"
  },
  {
    description = "Minecraft Bedrock World Packs",
    fileMatch = { "world_behavior_packs.json", "world_behavior_packs.jsonc", "world_behavior_packs.json5", "world_resource_packs.json", "world_resource_packs.jsonc", "world_resource_packs.json5" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/general/world_x_packs.json"
  },

  -- Language schemas
  {
    description = "Minecraft Bedrock Language Names",
    fileMatch = { "language_names.json", "language_names.jsonc", "language_names.json5" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/language/language_names.json"
  },
  {
    description = "Minecraft Bedrock Languages",
    fileMatch = { "languages.json", "languages.jsonc", "languages.json5" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/language/languages.json"
  },

  -- Skin pack schemas
  {
    description = "Minecraft Bedrock Skin Pack",
    fileMatch = { "skin_pack/skins.json", "skin_pack/skins.jsonc", "skin_pack/skins.json5" },
    url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/skinpacks/skins.json"
  },

  -- Resource Pack schemas
  {
    description = "Minecraft Bedrock Resource Pack Animation Controllers",
    fileMatch = {
      "resource_packs/*/animation_controllers/*.json",
      "resource_packs/*/animation_controllers/*.jsonc",
      "resource_packs/*/animation_controllers/*.json5",
      "*resource*pack*/animation_controllers/*.json",
      "*resource*pack*/animation_controllers/*.jsonc",
      "*resource*pack*/animation_controllers/*.json5",
      "*Resource*Pack*/animation_controllers/*.json",
      "*RP*/animation_controllers/*.json",
      "*rp*/animation_controllers/*.json",
      "*.animation_controller.rp.json",
      "*.rpac.json",
      "*.ac.rp.json",
      "*.rp_ac.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/animation_controllers/animation_controller.json"
  },
  {
    description = "Minecraft Bedrock Resource Pack Animations",
    fileMatch = {
      "resource_packs/*/animations/*.json",
      "*resource*pack*/animations/*.json",
      "*Resource*Pack*/animations/*.json",
      "*RP*/animations/*.json",
      "*rp*/animations/*.json",
      "*.animation.rp.json",
      "*.anim.rp.json",
      "*.a.rp.json",
      "*.rpa.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/animations/actor_animation.json"
  },
  {
    description = "Minecraft Bedrock Attachables",
    fileMatch = {
      "attachables/*.json",
      "*.attachable.json",
      "*.attach.json",
      "*.at.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/attachables/attachables.json"
  },
  {
    description = "Minecraft Bedrock Client Biomes",
    fileMatch = { "biomes_client.json", "biomes_client.jsonc", "biomes_client.json5" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/biomes_client.json"
  },
  {
    description = "Minecraft Bedrock Resource Blocks",
    fileMatch = { "blocks.json", "blocks.jsonc", "blocks.json5" },
    url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/blocks.json"
  },
  {
    description = "Minecraft Bedrock Client Entity",
    fileMatch = {
      "entity/*.json",
      "*.entity.rp.json",
      "*.e.rp.json",
      "*.ce.json",
      "*.rpe.json",
      "*.entity.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/entity/entity.json"
  },
  {
    description = "Minecraft Bedrock Fogs",
    fileMatch = {
      "fogs/*.json",
      "*.fog.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/fog/fog.json"
  },
  {
    description = "Minecraft Bedrock Flipbook Textures",
    fileMatch = { "flipbook_textures.json", "flipbook_textures.jsonc", "flipbook_textures.json5" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/textures/flipbook_textures.json"
  },
  {
    description = "Minecraft Bedrock Item Texture",
    fileMatch = { "item_texture.json", "item_texture.jsonc", "item_texture.json5" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/textures/item_texture.json"
  },
  {
    description = "Minecraft Bedrock Texture List",
    fileMatch = { "texture_list.json", "texture_list.jsonc", "texture_list.json5" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/textures/texture_list.json"
  },
  {
    description = "Minecraft Bedrock Resource Pack Items",
    fileMatch = {
      "resource_packs/*/items/*.json",
      "*resource*pack*/items/*.json",
      "*RP*/items/*.json",
      "*.item.rp.json",
      "*.i.rp.json",
      "*.rpi.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/items/items.json"
  },
  {
    description = "Minecraft Bedrock Entity Models",
    fileMatch = {
      "models/entity/*.json",
      "*.geo.json",
      "*.geometry.json",
      "*.model.json",
      "*.g.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/models/entity/model_entity.json"
  },
  {
    description = "Minecraft Bedrock Materials",
    fileMatch = { "materials/*.material" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/materials/materials.json"
  },
  {
    description = "Minecraft Bedrock Music Definitions",
    fileMatch = { "music_definitions.json" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/sounds/music_definitions.json"
  },
  {
    description = "Minecraft Bedrock Particles",
    fileMatch = {
      "particles/*.json",
      "*.particle.json",
      "*.p.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/particles/particles.json"
  },
  {
    description = "Minecraft Bedrock Render Controllers",
    fileMatch = {
      "render_controllers/*.json",
      "*.render.json",
      "*.render_controller.json",
      "*.rc.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/render_controllers/render_controllers.json"
  },
  {
    description = "Minecraft Bedrock Sound Definitions",
    fileMatch = { "sound_definitions.json", "sound_definitions.jsonc", "sound_definitions.json5" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/sounds/sound_definitions.json"
  },
  {
    description = "Minecraft Bedrock Sounds",
    fileMatch = { "sounds.json", "sounds.jsonc", "sounds.json5" },
    url = "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/sounds.json"
  },
  {
    description = "Minecraft Bedrock Terrain Texture",
    fileMatch = { "terrain_texture.json", "terrain_texture.jsonc", "terrain_texture.json5" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/resource/textures/terrain_texture.json"
  },

  -- Behavior Pack schemas
  {
    description = "Minecraft Bedrock Behavior Pack Animation Controllers",
    fileMatch = {
      "behavior_packs/*/animation_controllers/*.json",
      "*behavior*pack*/animation_controllers/*.json",
      "*Behavior*Pack*/animation_controllers/*.json",
      "*BP*/animation_controllers/*.json",
      "*bp*/animation_controllers/*.json",
      "*.animation_controller.bp.json",
      "*.bpac.json",
      "*.ac.bp.json",
      "*.bp_ac.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/animation_controllers/animation_controller.json"
  },
  {
    description = "Minecraft Bedrock Behavior Pack Animations",
    fileMatch = {
      "behavior_packs/*/animations/*.json",
      "*behavior*pack*/animations/*.json",
      "*BP*/animations/*.json",
      "*.animation.bp.json",
      "*.anim.bp.json",
      "*.a.bp.json",
      "*.bpa.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/animations/animations.json"
  },
  {
    description = "Minecraft Bedrock Biomes",
    fileMatch = {
      "behavior_packs/*/biomes/*.json",
      "*behavior*pack*/biomes/*.json",
      "*BP*/biomes/*.json",
      "*.biome.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/biomes/biomes.json"
  },
  {
    description = "Minecraft Bedrock Dialogue",
    fileMatch = {
      "behavior_packs/*/dialogue/*.json",
      "*behavior*pack*/dialogue/*.json",
      "*BP*/dialogue/*.json",
      "*.diag.json",
      "*.dialogue.json",
      "*.dialog.json",
      "*.d.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/dialogue/dialogue.json"
  },
  {
    description = "Minecraft Bedrock Function Tick",
    fileMatch = { "functions/tick.json", "functions/tick.jsonc", "functions/tick.json5" },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/functions/tick.json"
  },
  {
    description = "Minecraft Bedrock Loot Tables",
    fileMatch = {
      "behavior_packs/*/loot_tables/*.json",
      "*behavior*pack*/loot_tables/*.json",
      "*BP*/loot_tables/*.json",
      "*.loot.json",
      "*.loot_table.json",
      "*.lt.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/loot_tables/loot_tables.json"
  },
  {
    description = "Minecraft Bedrock Behavior Blocks",
    fileMatch = {
      "behavior_packs/*/blocks/*.json",
      "*behavior*pack*/blocks/*.json",
      "*BP*/blocks/*.json",
      "*.block.json",
      "*.b.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/blocks/blocks.json"
  },
  {
    description = "Minecraft Bedrock Behavior Entities",
    fileMatch = {
      "behavior_packs/*/entities/*.json",
      "*behavior*pack*/entities/*.json",
      "*BP*/entities/*.json",
      "*.entity.bp.json",
      "*.e.bp.json",
      "*.se.json",
      "*.bpe.json",
      "*.behavior.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/entities/entities.json"
  },
  {
    description = "Minecraft Bedrock Features",
    fileMatch = {
      "behavior_packs/*/features/*.json",
      "*behavior*pack*/features/*.json",
      "*BP*/features/*.json",
      "*.feature.json",
      "*.f.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/features/features.json"
  },
  {
    description = "Minecraft Bedrock Feature Rules",
    fileMatch = {
      "behavior_packs/*/feature_rules/*.json",
      "*behavior*pack*/feature_rules/*.json",
      "*BP*/feature_rules/*.json",
      "*.feature_rule.json",
      "*.fr.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/feature_rules/feature_rules.json"
  },
  {
    description = "Minecraft Bedrock Behavior Pack Items",
    fileMatch = {
      "behavior_packs/*/items/*.json",
      "*behavior*pack*/items/*.json",
      "*BP*/items/*.json",
      "*.item.bp.json",
      "*.i.bp.json",
      "*.bpi.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/items/items.json"
  },
  {
    description = "Minecraft Bedrock Recipes",
    fileMatch = {
      "recipes/*.json",
      "*.recipe.json",
      "*.crafting_recipe.json",
      "*.cr.json",
      "*.r.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/recipes/recipes.json"
  },
  {
    description = "Minecraft Bedrock Spawn Rules",
    fileMatch = {
      "spawn_rules/*.json",
      "*.spawn.json",
      "*.sr.json",
      "*.spawn_rule.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/spawn_rules/spawn_rules.json"
  },
  {
    description = "Minecraft Bedrock Trading",
    fileMatch = {
      "behavior_packs/*/trading/*.json",
      "*behavior*pack*/trading/*.json",
      "*BP*/trading/*.json",
      "*.trade.json",
      "*.trade_table.tt.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/trading/trading.json"
  },
  {
    description = "Minecraft Bedrock Volumes",
    fileMatch = {
      "behavior_packs/*/volumes/*.json",
      "*behavior*pack*/volumes/*.json",
      "*BP*/volumes/*.json",
      "*.volume.json"
    },
    url =
    "https://raw.githubusercontent.com/Blockception/Minecraft-bedrock-json-schemas/main/behavior/volumes/volumes.json"
  }
}

local function matches(pattern, filepath)
  filepath = filepath:gsub("\\", "/")

  -- ensure pattern matches anywhere
  if not pattern:match("^%*%*") then
    pattern = "**/" .. pattern
  end

  local matcher = vim.glob.to_lpeg(pattern)
  return matcher:match(filepath) ~= nil
end

local function matches_any(patterns, filepath)
  for _, pattern in ipairs(patterns) do
    if matches(pattern, filepath) then
      return true
    end
  end
  return false
end

local function find_schema(filepath)
  for _, entry in ipairs(schemas) do
    if matches_any(entry.fileMatch, filepath) == true then
      return entry
    end
  end

  return nil
end

local function fetch_schema(url)
  local result = vim.system(
    { "curl", "-fsSL", url },
    { text = true }
  ):wait()

  if result.code ~= 0 then
    error("Failed to fetch schema: " .. result.stderr)
  end

  return vim.json.decode(result.stdout)
end

local function build_default(schema)
  local default = schema.defaultSnippets[1].body
  local json = vim.json.encode(default)
  return json
end

vim.api.nvim_create_user_command("Test", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  local schema_data = find_schema(filepath)

  if schema_data == nil then
    vim.print("no schema found")
    return
  end

  local schema = fetch_schema(schema_data.url)
  local json = build_default(schema)

  vim.print(json)

  vim.api.nvim_put(vim.split(json, "\n"), "l", true, true)
end, {})

return {}
