# Exercise 04 — Build a Minimal XML + Lua UI

Goal: Create a small frame via XML and hook it to Lua so it prints your player's level on show.

Files to create/edit
- `UI/SampleFrame.xml` (XML markup)
- `Core/SampleUI.lua` (Lua handler)

XML (SampleFrame.xml)

```xml
<Ui xmlns="http://www.blizzard.com/wow/ui/">
  <Frame name="APR_SampleFrame" parent="UIParent">
    <Size>
      <AbsDimension x="200" y="80" />
    </Size>
    <Anchors>
      <Anchor point="CENTER" />
    </Anchors>
    <Layers>
      <Layer level="ARTWORK">
        <FontString name="$parentText" inherits="GameFontNormal">
          <Anchors>
            <Anchor point="CENTER" />
          </Anchors>
          <Text>Sample</Text>
        </FontString>
      </Layer>
    </Layers>
    <Scripts>
      <OnShow>APR_Sample_OnShow(self)</OnShow>
    </Scripts>
  </Frame>
</Ui>
```

Lua (Core/SampleUI.lua)

```lua
function APR_Sample_OnShow(frame)
    local lvl = UnitLevel('player')
    frame.text:SetText('Level: '..(lvl or '?'))
end
```

Test
- Add `UI/SampleFrame.xml` and `Core/SampleUI.lua` to the TOC and `/reload` in-game.
- Show the frame manually: `/run APR_SampleFrame:Show()` if it's been created.

Notes
- Use `frame.text = _G[frame:GetName()..'Text']` in OnLoad if you want to cache child references.
- Keep logic in Lua; XML only for layout and script hook names.