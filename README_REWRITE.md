# QuestMaster Pro — Rewrite (rewrite/from-scratch)

This branch contains a minimal, clean scaffold for QuestMaster Pro. It is intentionally small so we can iterate safely.

What is included:
- `QuestMasterPro.toc` — addon metadata for the rewrite
- `Main.lua` — minimal loader and slash command
- `Core/Init.lua` — event initialization and saved-variables restore
- `Core/Utils.lua` — small utility helpers
- `UI/MainFrame.lua` — basic, toggleable main UI frame

Notes:
- Original repository files remain in the repo (not deleted) and can be archived on request.
- I preserved the GPL-3.0 license file.

Next steps I can take:
- Port guides from `Data/` into a cleaned format
- Add unit/luacheck checks and CI
- Expand features to match the original addon incrementally
