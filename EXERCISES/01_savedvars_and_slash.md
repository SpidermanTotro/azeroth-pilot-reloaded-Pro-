# Exercise 01 — SavedVariables + Slash Command

Goal: Create a small addon module that stores a `debug` boolean in a SavedVariables table and toggles it with `/qmp debug`.

Task:
- Ensure `AzerothPilotDB` exists.
- Implement a slash command `/qmp debug` that toggles `AzerothPilotDB.debug` and prints the new state.

Solution (example):

```lua
-- Ensure saved table
AzerothPilotDB = AzerothPilotDB or {}
AzerothPilotDB.debug = AzerothPilotDB.debug or false

SLASH_QMP1 = '/qmp'
SlashCmdList['QMP'] = function(msg)
    local cmd = msg:match('^%S+')
    if cmd == 'debug' then
        AzerothPilotDB.debug = not AzerothPilotDB.debug
        print('AzerothPilot debug =', AzerothPilotDB.debug)
    else
        print('usage: /qmp debug')
    end
end
```

Notes:
- The saved table must be declared in the TOC as a SavedVariable to persist between sessions.
- Use `AzerothPilotDB = AzerothPilotDB or {}` pattern on PLAYER_LOGIN if needed.

Check: run the code in-game, type `/qmp debug` twice; the printed state should flip.