# Lesson 2 — Lua events and SavedVariables

Goal: learn common Lua patterns for WoW addons: registering events, saved variables, and safe OnEvent handlers.

Typical pattern
1. Create a frame: `local f = CreateFrame("Frame")`
2. Register an event: `f:RegisterEvent("PLAYER_LOGIN")`
3. Set an OnEvent script: `f:SetScript("OnEvent", function(self, event, ...)
     if event == "PLAYER_LOGIN" then ... end
   end)`

SavedVariables
- Declared in the `.toc` with `## SavedVariables: MyAddonDB`
- Accessed directly in Lua (global): check for `if MyAddonDB == nil then MyAddonDB = {} end`
- Persist between sessions and characters depending on `SavedVariablesPerCharacter`.

Exercise
- Open `templates/SampleSample.lua`. Identify where the SavedVariables are created and how the addon registers for `PLAYER_LOGIN`.
- Modify `SampleSample.lua` to store a timestamp when it loads (e.g., `SampleAddonDB.loadedAt = time()`), then run the `scripts/run-luacheck.sh` to lint the Lua.

Notes
- Avoid relying on global side-effects during load—use `PLAYER_LOGIN` to ensure APIs are available.
