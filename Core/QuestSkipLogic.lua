-- QuestSkipLogic.lua - Dynamic Quest Skip System
-- Intelligently detects when quests should be skipped

QuestMasterPro.QuestSkip = QuestMasterPro.QuestSkip or {}

local QuestSkip = QuestMasterPro.QuestSkip

-- Configuration
QuestSkip.config = {
    autoSkipOverleveled = true,
    skipThreshold = 3, -- Skip quests 3+ levels below player
    warnOnLongQuests = true,
    longQuestThreshold = 15, -- Warn on quests taking 15+ minutes
    skipGrindy = true, -- Skip "kill 50 mobs" type quests
    grindyThreshold = 30, -- 30+ kills = grindy
}

-- Quest efficiency ratings
QuestSkip.questRatings = {
    -- Format: [questID] = {xpPerMin, timeEstimate, difficulty, skip}
    -- These would be populated from community data
}

-- Check if a quest should be skipped
function QuestSkip:ShouldSkipQuest(questID, questLevel)
    local playerLevel = UnitLevel("player")
    local levelDiff = playerLevel - questLevel
    
    -- Skip if too low level
    if self.config.autoSkipOverleveled and levelDiff >= self.config.skipThreshold then
        return true, string.format("Quest is %d levels below you (grey quest, minimal XP)", levelDiff)
    end
    
    -- Check if quest is known to be inefficient
    if self.questRatings[questID] then
        local rating = self.questRatings[questID]
        if rating.skip then
            return true, rating.skipReason or "Quest marked as inefficient"
        end
    end
    
    return false, nil
end

-- Analyze quest objectives for grindiness
function QuestSkip:IsQuestGrindy(questID)
    if not self.config.skipGrindy then return false end
    
    local objectives = C_QuestLog.GetQuestObjectives(questID)
    if not objectives then return false end
    
    for _, obj in ipairs(objectives) do
        -- Check for high kill counts
        if obj.type == "monster" and obj.numRequired and obj.numRequired >= self.config.grindyThreshold then
            return true, string.format("Requires killing %d enemies (very grindy)", obj.numRequired)
        end
        
        -- Check for collection quests with low drop rates
        if obj.type == "item" and obj.numRequired and obj.numRequired >= 20 then
            return true, string.format("Requires collecting %d items (potentially low drop rate)", obj.numRequired)
        end
    end
    
    return false, nil
end

-- Get quest completion time estimate
function QuestSkip:EstimateQuestTime(questID)
    -- Check our database first
    if self.questRatings[questID] and self.questRatings[questID].timeEstimate then
        return self.questRatings[questID].timeEstimate
    end
    
    -- Make educated guess based on objectives
    local objectives = C_QuestLog.GetQuestObjectives(questID)
    if not objectives then return 5 end -- Default 5 minutes
    
    local estimatedTime = 2 -- Base time
    
    for _, obj in ipairs(objectives) do
        if obj.type == "monster" then
            -- ~1 minute per 5 kills
            estimatedTime = estimatedTime + (obj.numRequired or 10) / 5
        elseif obj.type == "item" then
            -- ~1 minute per 3 items (accounting for drop rates)
            estimatedTime = estimatedTime + (obj.numRequired or 5) / 3
        elseif obj.type == "object" then
            -- ~30 seconds per interact
            estimatedTime = estimatedTime + (obj.numRequired or 1) * 0.5
        end
    end
    
    return math.ceil(estimatedTime)
end

-- Calculate XP per minute for a quest
function QuestSkip:CalculateXPPerMinute(questID, questLevel)
    local questInfo = C_QuestLog.GetQuestInfo(questID)
    if not questInfo then return 0 end
    
    -- Get quest XP reward
    local xpReward = GetQuestLogRewardXP(questID)
    if not xpReward or xpReward == 0 then
        xpReward = 1000 -- Default estimate
    end
    
    -- Get time estimate
    local timeEstimate = self:EstimateQuestTime(questID)
    
    -- Calculate XP/min
    local xpPerMin = xpReward / timeEstimate
    
    return xpPerMin, xpReward, timeEstimate
end

-- Display skip recommendation
function QuestSkip:ShowSkipRecommendation(questID, questName, reason)
    local message = string.format(
        "|cffff0000[SKIP RECOMMENDED]|r %s - |cffaaaaaa%s|r",
        questName or "Quest",
        reason
    )
    
    print(message)
    
    if QuestMasterPro.UI and QuestMasterPro.UI.ShowNotification then
        QuestMasterPro.UI.ShowNotification("Quest Skip Suggestion", message, 8)
    end
end

-- Analyze quest when accepted
function QuestSkip:AnalyzeQuest(questID)
    local questInfo = C_QuestLog.GetInfo(questID)
    if not questInfo then return end
    
    local questName = questInfo.title
    local questLevel = questInfo.level or 1
    
    -- Check if should skip
    local shouldSkip, skipReason = self:ShouldSkipQuest(questID, questLevel)
    if shouldSkip then
        self:ShowSkipRecommendation(questID, questName, skipReason)
        return
    end
    
    -- Check if grindy
    local isGrindy, grindReason = self:IsQuestGrindy(questID)
    if isGrindy then
        self:ShowSkipRecommendation(questID, questName, grindReason)
        return
    end
    
    -- Check time efficiency
    if self.config.warnOnLongQuests then
        local timeEstimate = self:EstimateQuestTime(questID)
        if timeEstimate >= self.config.longQuestThreshold then
            local xpPerMin = self:CalculateXPPerMinute(questID, questLevel)
            local message = string.format(
                "|cffffff00[CAUTION]|r %s - Estimated %d minutes (%.0f XP/min)",
                questName,
                timeEstimate,
                xpPerMin
            )
            print(message)
        end
    end
end

-- Hook into quest accept
function QuestSkip:HookQuestAccept()
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("QUEST_ACCEPTED")
    frame:SetScript("OnEvent", function(self, event, questID)
        if event == "QUEST_ACCEPTED" then
            C_Timer.After(0.5, function()
                QuestSkip:AnalyzeQuest(questID)
            end)
        end
    end)
end

-- Get all current quests and analyze them
function QuestSkip:AnalyzeCurrentQuests()
    local numQuests = C_QuestLog.GetNumQuestLogEntries()
    local analyzed = 0
    
    for i = 1, numQuests do
        local info = C_QuestLog.GetInfo(i)
        if info and not info.isHeader and not info.isHidden then
            local questID = info.questID
            if questID then
                self:AnalyzeQuest(questID)
                analyzed = analyzed + 1
            end
        end
    end
    
    if analyzed > 0 then
        print(string.format("|cff00ff00[QuestMaster Pro]|r Analyzed %d quests for efficiency", analyzed))
    end
end

-- Initialize quest skip logic
function QuestSkip:Initialize()
    print("|cff00ff00[QuestMaster Pro]|r Quest Skip Logic loaded!")
    self:HookQuestAccept()
end

-- Slash commands
SLASH_QMPSKIP1 = "/qmpskip"
SLASH_QMPSKIP2 = "/skipquest"
SlashCmdList["QMPSKIP"] = function(msg)
    if msg == "analyze" then
        QuestSkip:AnalyzeCurrentQuests()
    elseif msg == "toggle" then
        QuestSkip.config.autoSkipOverleveled = not QuestSkip.config.autoSkipOverleveled
        print(string.format("|cff00ff00[QuestMaster Pro]|r Auto-skip overleveled quests: %s",
            QuestSkip.config.autoSkipOverleveled and "|cff00ff00ON|r" or "|cffff0000OFF|r"))
    else
        print("|cff00ff00[QuestMaster Pro Quest Skip]|r Commands:")
        print("  /skipquest analyze - Analyze current quests")
        print("  /skipquest toggle - Toggle auto-skip suggestions")
    end
end

return QuestSkip
