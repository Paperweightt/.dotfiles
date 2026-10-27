---
name: task-notify
description: Notify neovim (via nvr + nvim-notify) when a task is fully finished. Run as the final step before sending the closing response to the user, with a one-line summary of what was done.
---

## What I do

Pushes a toast notification into the running neovim via `nvr` (neovim-remote) and `nvim-notify`, so you see "task finished" in neovim without switching windows. Mirrors the `notifyNvim` helper in `esbuild.config.mjs:54`.

## When to fire

At the end of **every** task, after all edits and verification (lint, typecheck, `validate-bedrock-json`, tests, etc.) are done — as the **very last action** before sending the final response to the user. Skip only if the turn was pure clarification with no work performed.

## Command

Run via the bash tool (pwsh):

```
nvr -c 'lua require("notify")("opencode: <one-line summary>", 0)' 2>$null
```

- Level `0` = info (matches the esbuild default).
- Keep the summary plain ASCII, **no double quotes** inside it (they'd break the Lua string), collapsed to a single short line describing what was done.
- The `2>$null` guard makes this a silent no-op if `nvr` isn't on PATH — never fail the session over a missing notifier.

## Example

```
nvr -c 'lua require("notify")("opencode: added netherite trim to chestplate", 0)' 2>$null
```

## Notes

- Requires `nvr` (neovim-remote) on PATH and `nvim-notify` installed in the target neovim. If absent, the guard makes it a no-op.
- One notification per finished task — do not fire it mid-task or per-edit.
