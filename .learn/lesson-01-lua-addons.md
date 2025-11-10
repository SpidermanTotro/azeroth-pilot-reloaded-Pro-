# Lesson 01 — Lua for WoW Addons (minimal)

This short lesson covers the essentials to write safe, maintainable World of Warcraft addons using Lua 5.1 semantics.

Topics:
- Addon global namespace (use a single table, e.g., `QuestMasterPro`).
- SavedVariables basics (TOC `## SavedVariables:` and global table usage).
- Event frames and `SetScript("OnEvent")` handlers.
- Simple UI creation with `CreateFrame` and `FontString`.

Exercise:
1. Open `UI/MainFrame.lua` and read the `Init` and `Toggle` functions.
2. Toggle the frame using the `/qmp` command in-game (or simulate via code).

Notes:
- Use `QuestMasterProDB` to persist settings. Wrap debug printing in a helper that checks a `debug` flag.
- Keep global names minimal to avoid collisions.
