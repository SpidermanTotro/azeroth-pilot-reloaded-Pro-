local SampleAddon = CreateFrame("Frame")
SampleAddon:RegisterEvent("PLAYER_LOGIN")
SampleAddon:SetScript("OnEvent", function(self, event)
  if event == "PLAYER_LOGIN" then
    if SampleAddonDB == nil then SampleAddonDB = {} end
    SampleAddonDB.learned = true
    print("Sample addon loaded; learned saved.")
  end
end)
