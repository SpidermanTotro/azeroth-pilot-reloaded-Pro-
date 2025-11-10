# Learn Lua for WoW Addons — Practical Guide

Purpose
- A concise, practical primer to safely edit and extend World of Warcraft addons (Lua 5.1 environment).
- Focus on patterns relevant to this repository: event-driven code, SavedVariables, frame scripts, and linting with `luacheck`.

1) Lua and the WoW runtime
- WoW uses Lua 5.1 with a sandboxed set of global APIs (C_*, Get*, Unit*, CreateFrame, etc.).
- No standard libraries like `io`/`os` for addons. Treat globals carefully.
- `self` in methods is just the first argument when you declare `function Obj:Method()` (syntactic sugar).

2) Addon structure
- `TOC` file (e.g., `QuestMasterPro.toc`) lists files and SavedVariables.
- SavedVariables are declared in the TOC and persisted by the game; use them for user preferences and per-character state.
- Use namespaced tables (e.g., `AzerothPilot` or `QuestMasterPro`) to avoid polluting the global space.

3) Event-driven programming
- Create a frame: `local f = CreateFrame("Frame")` and `f:RegisterEvent("PLAYER_LOGIN")`.
- Attach handler: `f:SetScript("OnEvent", function(self, event, ...) end)`.
- Common pattern: use `self` to refer to the frame; if you don't use `self` inside the handler, luacheck will warn about an unused argument — it's safe to rename to `_` for style if you won't use it.

4) SavedVariables pattern
- Declare in TOC: `## SavedVariables: AzerothPilotDB`.
- At startup (e.g., `PLAYER_LOGIN`) ensure a defaults pattern:

```
AzerothPilotDB = AzerothPilotDB or {}
AzerothPilotDB.enabled = AzerothPilotDB.enabled == nil and true or AzerothPilotDB.enabled
```

- Persist user toggles by writing to `AzerothPilotDB` inside slash commands or UI callbacks.

5) Slash commands
- Register with: `SLASH_APR1 = '/qmp'` and `SlashCmdList['APR'] = function(msg) end`.
- Parse args carefully: `local cmd = msg:match('^%S+')`.

6) UI frames and scripts
- Prefer `local frame = CreateFrame('Frame', 'MyFrame', UIParent, 'BackdropTemplate')` and avoid global names unless necessary.
- Use `frame:SetScript('OnUpdate', function(self, elapsed) ... end)` for periodic updates but keep them efficient.
- Avoid heavy work in `OnUpdate` (throttle using accumulators or C_Timer).

7) Defensive programming & common pitfalls
- Always guard external calls that may be nil in unit tests: `if C_QuestLog and C_QuestLog.GetNumQuestLogEntries then ... end`.
- Avoid shadowing important upvalues (e.g., don't name an inner closure param `self` if the outer scope uses `self` meaningfully).
- Use `local` liberally. Global leaks are common mistakes and can break other addons.

8) Linting with luacheck
- Use `luacheck` targeted at Lua 5.1 and declare WoW globals in `.luacheckrc`.
- Typical rules: mark unused handler args as `_` or configure `.luacheckrc` to allow them.
- Example `.luacheckrc` snippets are present in the repo.

9) Testing and iteration
- Edit files locally, commit on a feature branch, and test in-game by reloading the UI (`/reload`) and checking for lua errors.
- Keep commits small and focused: data fixes vs UI behavior vs style changes should be separate.

10) Where to go from here
- Use the `EXERCISES/` directory for practical practice. After you’re comfortable, review this repo’s branches and PRs.

---
Notes: this guide is intentionally short and pragmatic. For language fundamentals, see the Lua 5.1 manual; for WoW-specific APIs, use the in-game API docs and WoW UI development resources.