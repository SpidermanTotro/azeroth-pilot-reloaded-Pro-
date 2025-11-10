# WoW XML UI Guide — Practical Patterns

This short guide covers XML->Lua integration patterns that are safe and testable.

XML basics
- Root element: `<Ui xmlns="http://www.blizzard.com/wow/ui/">`
- Frames are declared with `<Frame name="MyFrame" parent="UIParent"> ... </Frame>`
- You can embed `<Scripts>` sections with `OnLoad`, `OnShow`, `OnClick`, etc.

Example: XML + Lua pairing
- `UI/MainFrame.xml` contains frame markup and script hooks:

  <Scripts>
    <OnLoad>APR_Main_OnLoad(self)</OnLoad>
  </Scripts>

- `Core/Main.lua` implements the handler:

  function APR_Main_OnLoad(self)
    APR = APR or {}
    APR.frame = self
    self:RegisterEvent('PLAYER_LOGIN')
    self:SetScript('OnEvent', function(_, event, ...)
      if event == 'PLAYER_LOGIN' then
        APR:Initialize()
      end
    end)
  end

Notes and best practices
- Keep XML script handlers thin: call into Lua functions instead of writing logic in XML strings.
- Use named children via `$parentChildName` convention to reference subframes from Lua.
- Prefer Lua for complex logic; use XML for static layout and templates.

Secure templates
- Use `<Button name="MySecureButton" inherits="SecureActionButtonTemplate">` to create clickable secure buttons.
- Use `SetAttribute` to configure secure behavior in Lua for secure frames.

Troubleshooting
- "Protected function" errors occur when trying to change secure attributes during combat.
- To debug: reproduce outside of combat, add print statements, and consult the Lua error frame.

Resources
- Official Blizzard UI XML schema (in-game and online).
- Community guides: Wowpedia and WoW UI Dev forum discussions.

This file is a concise reference — the exercises include a hands-on XML+Lua example to practice the flow.