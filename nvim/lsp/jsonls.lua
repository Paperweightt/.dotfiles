---@brief
---
--- https://github.com/hrsh7th/vscode-langservers-extracted
---
--- vscode-json-language-server, a language server for JSON and JSON schema
---
--- `vscode-json-language-server` can be installed via `npm`:
--- ```sh
--- npm i -g vscode-langservers-extracted
--- ```
---
--- `vscode-json-language-server` only provides completions when snippet support is enabled. If you use Neovim older than v0.10 you need to enable completion, install a snippet plugin and add the following override to your language client capabilities during setup.
---
--- ```lua
--- --Enable (broadcasting) snippet capability for completion
--- local capabilities = vim.lsp.protocol.make_client_capabilities()
--- capabilities.textDocument.completion.completionItem.snippetSupport = true
---
--- vim.lsp.config('jsonls', {
---   capabilities = capabilities,
--- })
--- ```

vim.filetype.add({
  extension = {
    json = "jsonc",
    material = "jsonc"
  },
})

return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
  settings = {
    json = {
      schemas = {
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
    }
  }
}
