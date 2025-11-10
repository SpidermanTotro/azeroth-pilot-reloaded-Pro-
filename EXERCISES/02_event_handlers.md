# Exercise 02 — Event Handler and Defensive Guards

Goal: Register a frame for `PLAYER_LOGIN` and `QUEST_LOG_UPDATE` and print a message when the player logs in.

Task:
- Create a frame, register events, and implement `OnEvent` safely.
- Demonstrate a guard around a global API call.

Solution:

```lua
local f = CreateFrame('Frame')
f:RegisterEvent('PLAYER_LOGIN')
f:RegisterEvent('QUEST_LOG_UPDATE')

f:SetScript('OnEvent', function(self, event, ...)
    if event == 'PLAYER_LOGIN' then
        print('Addon loaded for', UnitName('player'))
        -- ensure saved vars exist
        AzerothPilotDB = AzerothPilotDB or {}
    elseif event == 'QUEST_LOG_UPDATE' then
        if C_QuestLog and C_QuestLog.GetNumQuestLogEntries then
            local n = C_QuestLog.GetNumQuestLogEntries()
            -- do something
        end
    end
end)
```

Notes:
- If `self` is unused inside the handler, luacheck will warn. You can rename it to `_` if you prefer.
- Always guard calls into API tables that may not exist in certain clients or environments.
