# Exercise 05 — Debugging and Safe Testing

Goal: Practice safe debugging steps for WoW addons: enabling Lua errors, using SavedVariables, and testing a change with minimal risk.

Steps
1) Enable Lua errors in-game
   - `/console scriptErrors 1`

2) Add a debug wrapper in your addon

```lua
function AzerothPilot:DebugPrint(...)
    if AzerothPilotDB and AzerothPilotDB.debug then
        print('|cFF00D4FF[AzerothPilot]|r', ...)
    end
end
```

3) Use `/reload` to test UI reloads. Check the error frame after reload.

4) Inspect SavedVariables
   - Log out, open the SavedVariables file for your character, and verify values (or add temporary prints to write values to chat).

5) Reproducing & fixing a protected error
   - If you see "Attempted to call a protected function" when trying to change secure attributes in combat, reproduce the change out-of-combat and modify code to use `RegisterStateDriver` or secure templates.

6) Rolling back
   - If a PR introduces a regression, revert with `git revert <commit>` and open a follow-up PR that fixes the root cause.

This exercise practices careful testing and safe rollback procedures — essential when maintaining live addons.