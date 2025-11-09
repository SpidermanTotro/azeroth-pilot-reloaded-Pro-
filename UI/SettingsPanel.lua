-- Azeroth Pilot Reloaded Pro - Settings Panel
-- Configuration interface for the addon

AzerothPilot.UI.Settings = {}
local Settings = AzerothPilot.UI.Settings

-- Create settings panel
function Settings:CreatePanel()
    local panel = CreateFrame("Frame", "AzerothPilotSettingsPanel", UIParent)
    panel.name = "Azeroth Pilot Pro"
    
    -- Title
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("Azeroth Pilot Reloaded Pro")
    
    -- Subtitle
    local subtitle = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    subtitle:SetText("The ultimate leveling guide for World of Warcraft")
    
    -- Enable addon checkbox
    local enableCheckbox = CreateFrame("CheckButton", "APEnableCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
    enableCheckbox:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -20)
    enableCheckbox.Text:SetText("Enable Azeroth Pilot Pro")
    enableCheckbox:SetChecked(AzerothPilotDB.enabled)
    enableCheckbox:SetScript("OnClick", function(self)
        AzerothPilotDB.enabled = self:GetChecked()
        AzerothPilot:Print("Addon " .. (AzerothPilotDB.enabled and "enabled" or "disabled"))
    end)
    
    -- Show arrow checkbox
    local arrowCheckbox = CreateFrame("CheckButton", "APArrowCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
    arrowCheckbox:SetPoint("TOPLEFT", enableCheckbox, "BOTTOMLEFT", 0, -8)
    arrowCheckbox.Text:SetText("Show Navigation Arrow")
    arrowCheckbox:SetChecked(AzerothPilotDB.showArrow)
    arrowCheckbox:SetScript("OnClick", function(self)
        AzerothPilotDB.showArrow = self:GetChecked()
        if AzerothPilot.UI.Arrow then
            AzerothPilot.UI.Arrow:UpdateVisibility()
        end
    end)
    
    -- Auto-accept quests checkbox
    local autoAcceptCheckbox = CreateFrame("CheckButton", "APAutoAcceptCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
    autoAcceptCheckbox:SetPoint("TOPLEFT", arrowCheckbox, "BOTTOMLEFT", 0, -8)
    autoAcceptCheckbox.Text:SetText("Auto-accept Quests")
    autoAcceptCheckbox:SetChecked(AzerothPilotDB.autoAccept)
    autoAcceptCheckbox:SetScript("OnClick", function(self)
        AzerothPilotDB.autoAccept = self:GetChecked()
    end)
    
    -- Auto-turn in quests checkbox
    local autoTurnInCheckbox = CreateFrame("CheckButton", "APAutoTurnInCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
    autoTurnInCheckbox:SetPoint("TOPLEFT", autoAcceptCheckbox, "BOTTOMLEFT", 0, -8)
    autoTurnInCheckbox.Text:SetText("Auto-turn in Quests")
    autoTurnInCheckbox:SetChecked(AzerothPilotDB.autoTurnIn)
    autoTurnInCheckbox:SetScript("OnClick", function(self)
        AzerothPilotDB.autoTurnIn = self:GetChecked()
    end)
    
    -- Sound enabled checkbox
    local soundCheckbox = CreateFrame("CheckButton", "APSoundCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
    soundCheckbox:SetPoint("TOPLEFT", autoTurnInCheckbox, "BOTTOMLEFT", 0, -8)
    soundCheckbox.Text:SetText("Enable Sounds")
    soundCheckbox:SetChecked(AzerothPilotDB.soundEnabled)
    soundCheckbox:SetScript("OnClick", function(self)
        AzerothPilotDB.soundEnabled = self:GetChecked()
    end)
    
    -- Version info
    local versionText = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    versionText:SetPoint("BOTTOMLEFT", 16, 16)
    versionText:SetText("Version: " .. AzerothPilot.Version)
    
    -- Register with Interface Options (Classic compatible)
    if Settings and Settings.RegisterCanvasLayoutCategory then
        -- Retail version
        local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
        Settings.RegisterAddOnCategory(category)
    elseif InterfaceOptions_AddCategory then
        -- Classic version
        InterfaceOptions_AddCategory(panel)
    end
    
    return panel
end

-- Initialize settings
function Settings:Initialize()
    self:CreatePanel()
    AzerothPilot:DebugPrint("Settings panel initialized")
end
