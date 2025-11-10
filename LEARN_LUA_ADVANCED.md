# Advanced: Learning Lua for WoW Addons (Deep Dive)

This advanced guide builds on the basics and focuses on practical topics you need to author, maintain and safely edit World of Warcraft addons that include XML UI files.

Contents
- Addon anatomy and TOC files
- SavedVariables and versioning
- Lua patterns in WoW (modules, metatables, frames)
- WoW XML UI basics and templates
- Secure handlers and secure environment considerations
- Event-driven design patterns and edge cases
- Debugging and testing workflows
- Useful tools and references

Addon anatomy & TOC
- A .toc file lists files and SavedVariables. Example header lines:

  ## Interface: 100105
  ## Title: QuestMaster Pro
  ## Notes: Leveling addon
  ## SavedVariables: AzerothPilotDB
  Core/Init.lua
  UI/MainFrame.xml
  UI/Overlay.lua

- Keep file order meaningful: libraries first, then core, then UI (XML + Lua), then Data.

SavedVariables best practices
- Declare in TOC and initialize defensively in `PLAYER_LOGIN`:

  AzerothPilotDB = AzerothPilotDB or {}
  AzerothPilotDB.settings = AzerothPilotDB.settings or {}

- Use explicit migration/versioning if you change the shape of saved data:

  if (AzerothPilotDB.version or 0) < 2 then
    -- migrate old fields
    AzerothPilotDB.version = 2
  end

Lua patterns and modules
- Use a single global namespace table (e.g., `AzerothPilot`) and store submodules on it.
- Prefer `local` for functions and frequently-used globals to improve performance and avoid leakage.
- Example module:

  local MyAddon = {}
  local M = MyAddon
  function M:Start()
    -- use M rather than global lookups
  end
  AzerothPilot.MyAddon = M

WoW XML UI basics
- XML files declare frames and templates. Example minimal XML fragment:

  <Ui xmlns="http://www.blizzard.com/wow/ui/">
    <Frame name="APRProMainWindow" parent="UIParent" hidden="false">
      <Size>
        <AbsDimension x="480" y="600" />
      </Size>
      <Anchors>
        <Anchor point="CENTER" />
      </Anchors>
      <Layers>
        <Layer level="ARTWORK">
          <FontString name="$parentTitle" inherits="GameFontNormalLarge">
            <Anchors>
              <Anchor point="TOP" x="0" y="-10" />
            </Anchors>
            <Text>QuestMaster Pro</Text>
          </FontString>
        </Layer>
      </Layers>
    </Frame>
  </Ui>

- XML refers to Lua functions by script handlers (e.g., `<Scripts><OnLoad>MyAddon_Main_OnLoad(self)</OnLoad></Scripts>`). Keep those handlers minimal and call into Lua modules.

Secure handlers and environment
- In secure environment (action buttons, secure templates), you must use secure templates and avoid insecure calls during combat.
- Use `SecureHandlerBaseTemplate` and `SecureHandlerStateTemplate` appropriately.
- Avoid creating frames or calling protected functions while in combat — WoW will throw a protected error.

Event-driven design patterns and edge cases
- Use a single event dispatcher frame for initialization; route events to modules.
- Throttle heavy work in `OnUpdate` and prefer `C_Timer.After` or an accumulator pattern.
- Guard feature detection: `if C_QuestLog and C_QuestLog.GetNumQuestLogEntries then ... end`

Debugging and testing
- Use `/reload` to reload UI while testing.
- Enable the Lua error frame: `Settings -> Interface -> Advanced -> Display Lua Errors` (or use `Slash command /console scriptErrors 1`).
- Inspect SavedVariables in the SavedVariables folder after logging out; use `AzerothPilotDB` to confirm persisted settings.
- Use `print`, `AzerothPilot:DebugPrint()` wrappers that respect a `debug` flag, and toggle through SavedVariables.

Tools & references
- luacheck: static linter tailored to Lua 5.1. Use `.luacheckrc` to declare WoW globals.
- WoW UI API docs (in-game or online WIKI).
- Useful libs: Ace3 (optional), LibStub (common loader pattern).

Next steps
- Follow `EXERCISES/04_xml_ui.md` to practice building an XML+Lua UI component.
- Add CI that runs `luacheck` on PRs and blocks merges with new errors.

This advanced guide is pragmatic: it focuses on the practical problems that break addons (state migrations, secure handler errors, excessive OnUpdate work) and how to avoid them.