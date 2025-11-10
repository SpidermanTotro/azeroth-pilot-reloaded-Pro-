# Exercise 03 — Using luacheck for WoW addons

Goal: Configure `luacheck` for a WoW addon and fix simple warnings.

Task:
- Write a `.luacheckrc` that targets Lua 5.1 and declares typical WoW globals (CreateFrame, UnitLevel, C_QuestLog, etc.).
- Fix a reported warning: "unused argument self" in a handler where `self` is not used.

Solution (example `.luacheckrc` snippet):

```
std = "lua51"
globals = {
    'CreateFrame', 'UIParent', 'GetTime', 'UnitLevel', 'UnitXP', 'UnitXPMax',
    'C_Timer', 'C_QuestLog', 'GameTooltip', 'SLASH_QMP1', 'SlashCmdList'
}

exclude_files = { 'Data/*.lua' }
max_line_length = 140
```

Fixing an unused arg warning:
- Change: `f:SetScript('OnUpdate', function(self, elapsed) ... end)`
- To: `f:SetScript('OnUpdate', function(_, elapsed) ... end)` or use `_self` if you want readability.

After edits run:
```
luacheck . --config .luacheckrc
```

Resolve any true errors first; use the config to suppress only known benign patterns.