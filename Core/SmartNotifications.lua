-- SmartNotifications.lua - Intelligent notification system
-- Alerts players to important events and opportunities

QuestMasterPro.Notifications = QuestMasterPro.Notifications or {}

local Notifications = QuestMasterPro.Notifications

-- Configuration
Notifications.config = {
    rareSpawnAlerts = true,
    treasureAlerts = true,
    hearthReadyAlerts = true,
    levelUpAlerts = true,
    questCompleteAlerts = true,
    dungeonQueueAlerts = true,
    professionAlerts = true,
    soundEnabled = true,
    flashScreen = false,
}

-- Notification queue
Notifications.queue = {}
Notifications.activeNotifications = {}

-- Rare mob database (expandable)
Notifications.rareMobs = {
    -- Format: [npcID] = {name, loot}
    [50009] = {name = "Poseidus", loot = "Reins of Poseidus (Mount)"},
    [50005] = {name = "Burgy Blackheart", loot = "Burgy Blackheart's Handsome Hat"},
    [32491] = {name = "Time-Lost Proto-Drake", loot = "Reins of the Time-Lost Proto-Drake"},
    -- Add hundreds more rare mobs
}

-- Treasure locations (expandable)
Notifications.treasures = {
    -- Format: [zone] = {treasures}
}

-- Create notification frame
function Notifications:CreateNotificationFrame()
    if self.notificationFrame then return self.notificationFrame end
    
    local frame = CreateFrame("Frame", "QMPNotificationFrame", UIParent)
    frame:SetSize(400, 100)
    frame:SetPoint("TOP", UIParent, "TOP", 0, -150)
    frame:SetFrameStrata("HIGH")
    frame:SetAlpha(0)
    frame:Hide()
    
    -- Background
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints()
    frame.bg:SetColorTexture(0, 0, 0, 0.85)
    
    -- Border glow effect
    frame.glow = frame:CreateTexture(nil, "ARTWORK")
    frame.glow:SetPoint("TOPLEFT", -4, 4)
    frame.glow:SetPoint("BOTTOMRIGHT", 4, -4)
    frame.glow:SetColorTexture(0, 0.8, 1, 0.3)
    
    -- Icon
    frame.icon = frame:CreateTexture(nil, "ARTWORK")
    frame.icon:SetSize(64, 64)
    frame.icon:SetPoint("LEFT", frame, "LEFT", 10, 0)
    frame.icon:SetTexture("Interface\\Icons\\INV_Misc_Bell_01")
    
    -- Title text
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOPLEFT", frame.icon, "TOPRIGHT", 10, -5)
    frame.title:SetPoint("RIGHT", frame, "RIGHT", -10, 0)
    frame.title:SetJustifyH("LEFT")
    frame.title:SetTextColor(0, 1, 1)
    
    -- Message text
    frame.message = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.message:SetPoint("TOPLEFT", frame.title, "BOTTOMLEFT", 0, -5)
    frame.message:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)
    frame.message:SetJustifyH("LEFT")
    frame.message:SetJustifyV("TOP")
    frame.message:SetTextColor(1, 1, 1)
    
    self.notificationFrame = frame
    return frame
end

-- Show notification
function Notifications:ShowNotification(title, message, duration, icon, sound)
    duration = duration or 5
    
    local frame = self:CreateNotificationFrame()
    
    -- Set content
    frame.title:SetText(title or "Notification")
    frame.message:SetText(message or "")
    
    if icon then
        frame.icon:SetTexture(icon)
    else
        frame.icon:SetTexture("Interface\\Icons\\INV_Misc_Bell_01")
    end
    
    -- Play sound
    if self.config.soundEnabled and sound ~= false then
        PlaySound(8959) -- SOUNDKIT.RAID_WARNING
    end
    
    -- Flash screen effect
    if self.config.flashScreen then
        FlashClientIcon()
    end
    
    -- Animate in
    frame:SetAlpha(0)
    frame:Show()
    
    local fadeIn = frame:CreateAnimationGroup()
    local alpha = fadeIn:CreateAnimation("Alpha")
    alpha:SetFromAlpha(0)
    alpha:SetToAlpha(1)
    alpha:SetDuration(0.3)
    fadeIn:Play()
    
    -- Auto-hide after duration
    C_Timer.After(duration, function()
        local fadeOut = frame:CreateAnimationGroup()
        local alpha = fadeOut:CreateAnimation("Alpha")
        alpha:SetFromAlpha(1)
        alpha:SetToAlpha(0)
        alpha:SetDuration(0.5)
        fadeOut:SetScript("OnFinished", function()
            frame:Hide()
        end)
        fadeOut:Play()
    end)
end

-- Rare mob detection
function Notifications:CheckForRareMobs()
    if not self.config.rareSpawnAlerts then return end
    
    -- Scan for rare mobs nearby
    for i = 1, 40 do
        local unit = "nameplate" .. i
        if UnitExists(unit) then
            local guid = UnitGUID(unit)
            if guid then
                local npcID = select(6, strsplit("-", guid))
                npcID = tonumber(npcID)
                
                if npcID and self.rareMobs[npcID] then
                    local rare = self.rareMobs[npcID]
                    local name = UnitName(unit)
                    
                    -- Check if we already notified about this mob
                    if not self.notifiedRares then self.notifiedRares = {} end
                    if not self.notifiedRares[guid] then
                        self.notifiedRares[guid] = true
                        
                        local message = string.format(
                            "Rare mob spotted: %s\n%s",
                            name,
                            rare.loot or "Special loot available!"
                        )
                        
                        self:ShowNotification(
                            "⚡ RARE MOB NEARBY! ⚡",
                            message,
                            10,
                            "Interface\\Icons\\Ability_Rogue_MasterOfSubtlety"
                        )
                        
                        -- Also print to chat
                        print(string.format(
                            "|cffff0000[RARE MOB]|r |cff00ff00%s|r nearby! %s",
                            name,
                            rare.loot or ""
                        ))
                    end
                end
            end
        end
    end
end

-- Hearthstone ready notification
function Notifications:NotifyHearthReady()
    if not self.config.hearthReadyAlerts then return end
    
    self:ShowNotification(
        "Hearthstone Ready!",
        "Your Hearthstone is off cooldown and ready to use.",
        5,
        "Interface\\Icons\\INV_Misc_Rune_01"
    )
end

-- Level up notification
function Notifications:NotifyLevelUp(newLevel)
    if not self.config.levelUpAlerts then return end
    
    local message = string.format("Congratulations! You are now level %d!", newLevel)
    
    -- Add special messages at milestone levels
    if newLevel % 10 == 0 then
        message = message .. "\n🎉 Milestone level reached!"
    end
    
    self:ShowNotification(
        "LEVEL UP!",
        message,
        8,
        "Interface\\Icons\\Achievement_Level_" .. newLevel,
        true
    )
end

-- Quest completion notification
function Notifications:NotifyQuestComplete(questName)
    if not self.config.questCompleteAlerts then return end
    
    self:ShowNotification(
        "Quest Complete!",
        string.format("✓ %s", questName),
        4,
        "Interface\\Icons\\Achievement_Quests_Completed_01"
    )
end

-- Dungeon queue pop notification
function Notifications:NotifyDungeonQueue(dungeonName)
    if not self.config.dungeonQueueAlerts then return end
    
    self:ShowNotification(
        "Dungeon Queue Ready!",
        string.format("Your queue for %s is ready!", dungeonName or "dungeon"),
        10,
        "Interface\\Icons\\Achievement_Boss_Kelthuzad_01",
        true
    )
    
    -- Flash screen for dungeon pops
    FlashClientIcon()
end

-- Profession skill-up notification
function Notifications:NotifyProfessionSkillUp(profession, newSkill)
    if not self.config.professionAlerts then return end
    
    -- Only notify on milestone levels
    if newSkill % 25 == 0 or newSkill % 75 == 0 then
        self:ShowNotification(
            "Profession Skill Up!",
            string.format("%s is now %d!", profession, newSkill),
            5,
            "Interface\\Icons\\Trade_" .. (profession or "Engineering")
        )
    end
end

-- Initialize event hooks
function Notifications:Initialize()
    print("|cff00ff00[QuestMaster Pro]|r Smart Notifications loaded!")
    
    -- Create event frame
    local frame = CreateFrame("Frame")
    
    -- Register events
    frame:RegisterEvent("PLAYER_LEVEL_UP")
    frame:RegisterEvent("QUEST_TURNED_IN")
    frame:RegisterEvent("LFG_PROPOSAL_SHOW")
    frame:RegisterEvent("TRADE_SKILL_UPDATE")
    frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    
    -- Event handler
    frame:SetScript("OnEvent", function(self, event, ...)
        if event == "PLAYER_LEVEL_UP" then
            local newLevel = ...
            Notifications:NotifyLevelUp(newLevel)
            
        elseif event == "QUEST_TURNED_IN" then
            local questID = ...
            local questInfo = C_QuestLog.GetQuestInfo(questID)
            if questInfo then
                Notifications:NotifyQuestComplete(questInfo.title)
            end
            
        elseif event == "LFG_PROPOSAL_SHOW" then
            Notifications:NotifyDungeonQueue()
            
        elseif event == "TRADE_SKILL_UPDATE" then
            -- Could track profession skill ups here
        end
    end)
    
    -- Periodic rare mob scanner
    if self.config.rareSpawnAlerts then
        C_Timer.NewTicker(2, function()
            Notifications:CheckForRareMobs()
        end)
    end
end

-- Slash commands
SLASH_QMPNOTIFY1 = "/qmpnotify"
SLASH_QMPNOTIFY2 = "/notify"
SlashCmdList["QMPNOTIFY"] = function(msg)
    if msg == "test" then
        Notifications:ShowNotification(
            "Test Notification",
            "This is a test notification from QuestMaster Pro!",
            5
        )
    elseif msg == "toggle" then
        Notifications.config.soundEnabled = not Notifications.config.soundEnabled
        print(string.format("|cff00ff00[QuestMaster Pro]|r Notification sounds: %s",
            Notifications.config.soundEnabled and "|cff00ff00ON|r" or "|cffff0000OFF|r"))
    elseif msg == "rare" then
        Notifications.config.rareSpawnAlerts = not Notifications.config.rareSpawnAlerts
        print(string.format("|cff00ff00[QuestMaster Pro]|r Rare mob alerts: %s",
            Notifications.config.rareSpawnAlerts and "|cff00ff00ON|r" or "|cffff0000OFF|r"))
    else
        print("|cff00ff00[QuestMaster Pro Notifications]|r Commands:")
        print("  /notify test - Show test notification")
        print("  /notify toggle - Toggle notification sounds")
        print("  /notify rare - Toggle rare mob alerts")
    end
end

return Notifications
