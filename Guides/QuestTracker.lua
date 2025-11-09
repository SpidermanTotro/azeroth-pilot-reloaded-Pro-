-- Azeroth Pilot Reloaded Pro - Quest Tracker
-- Advanced quest tracking that outperforms AAP and Zygor

AzerothPilot.Guides.QuestTracker = {}
local QuestTracker = AzerothPilot.Guides.QuestTracker

QuestTracker.trackedQuests = {}

-- Initialize quest tracker
function QuestTracker:Initialize()
    AzerothPilot:DebugPrint("Quest Tracker initialized")
    
    -- Register quest events
    AzerothPilot.EventFrame:RegisterEvent("QUEST_LOG_UPDATE")
    AzerothPilot.EventFrame:RegisterEvent("QUEST_ACCEPTED")
    AzerothPilot.EventFrame:RegisterEvent("QUEST_TURNED_IN")
    AzerothPilot.EventFrame:RegisterEvent("QUEST_WATCH_UPDATE")
end

-- Track a quest
function QuestTracker:TrackQuest(questID)
    if not questID then
        return false
    end
    
    if not C_QuestLog.GetLogIndexForQuestID(questID) then
        AzerothPilot:DebugPrint("Quest not in log: " .. questID)
        return false
    end
    
    self.trackedQuests[questID] = true
    C_QuestLog.AddQuestWatch(questID)
    
    AzerothPilot:DebugPrint("Tracking quest: " .. questID)
    return true
end

-- Untrack a quest
function QuestTracker:UntrackQuest(questID)
    if not questID then
        return false
    end
    
    self.trackedQuests[questID] = nil
    C_QuestLog.RemoveQuestWatch(questID)
    
    return true
end

-- Check if quest is tracked
function QuestTracker:IsTracked(questID)
    return self.trackedQuests[questID] == true
end

-- Get quest progress
function QuestTracker:GetQuestProgress(questID)
    if not questID then
        return nil
    end
    
    local questLogIndex = C_QuestLog.GetLogIndexForQuestID(questID)
    if not questLogIndex then
        return nil
    end
    
    local info = C_QuestLog.GetInfo(questLogIndex)
    if not info then
        return nil
    end
    
    return {
        title = info.title,
        level = info.level,
        isComplete = C_QuestLog.IsComplete(questID),
        isOnMap = info.isOnMap,
        hasLocalPOI = info.hasLocalPOI,
    }
end

-- Auto-accept quest if enabled
function QuestTracker:AutoAcceptQuest()
    if not AzerothPilotDB.autoAccept then
        return
    end
    
    -- This would hook into quest accept events
    AzerothPilot:DebugPrint("Auto-accept enabled")
end

-- Auto-turn in quest if enabled
function QuestTracker:AutoTurnInQuest()
    if not AzerothPilotDB.autoTurnIn then
        return
    end
    
    -- This would hook into quest turn-in events
    AzerothPilot:DebugPrint("Auto-turn in enabled")
end

-- Clear all tracked quests
function QuestTracker:ClearAll()
    for questID, _ in pairs(self.trackedQuests) do
        self:UntrackQuest(questID)
    end
    self.trackedQuests = {}
end

-- Get all tracked quests
function QuestTracker:GetTrackedQuests()
    local quests = {}
    for questID, _ in pairs(self.trackedQuests) do
        local progress = self:GetQuestProgress(questID)
        if progress then
            progress.questID = questID
            table.insert(quests, progress)
        end
    end
    return quests
end
