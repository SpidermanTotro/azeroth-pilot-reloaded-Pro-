-- Azeroth Pilot Reloaded Pro - Guide Engine
-- Advanced guide system with modern features that surpass competitors

AzerothPilot.Guides.Engine = {}
local Engine = AzerothPilot.Guides.Engine

Engine.activeGuide = nil
Engine.currentStepIndex = 1

-- Initialize the guide engine
function Engine:Initialize()
    AzerothPilot:DebugPrint("Guide Engine initialized")
    
    -- Register event handlers
    AzerothPilot.EventFrame:RegisterEvent("QUEST_ACCEPTED")
    AzerothPilot.EventFrame:RegisterEvent("QUEST_TURNED_IN")
    AzerothPilot.EventFrame:RegisterEvent("QUEST_REMOVED")
    AzerothPilot.EventFrame:RegisterEvent("PLAYER_LEVEL_UP")
    AzerothPilot.EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    
    -- Hook into original event handler
    local originalHandler = AzerothPilot.EventFrame:GetScript("OnEvent")
    AzerothPilot.EventFrame:SetScript("OnEvent", function(self, event, ...)
        originalHandler(self, event, ...)
        Engine:OnEvent(event, ...)
    end)
end

-- Event handler
function Engine:OnEvent(event, ...)
    if event == "QUEST_ACCEPTED" then
        local questID = ...
        self:OnQuestAccepted(questID)
    elseif event == "QUEST_TURNED_IN" then
        local questID = ...
        self:OnQuestTurnedIn(questID)
    elseif event == "QUEST_REMOVED" then
        local questID = ...
        self:OnQuestRemoved(questID)
    elseif event == "PLAYER_LEVEL_UP" then
        local level = ...
        self:OnLevelUp(level)
    elseif event == "ZONE_CHANGED_NEW_AREA" then
        self:OnZoneChanged()
    end
end

-- Start a guide
function Engine:StartGuide(guideId)
    local guide = AzerothPilot.Database:GetGuide(guideId)
    if not guide then
        AzerothPilot:Print("Guide not found: " .. tostring(guideId))
        return false
    end
    
    self.activeGuide = guide
    self.currentStepIndex = 1
    
    AzerothPilotCharDB.currentGuide = guideId
    AzerothPilotCharDB.currentStep = 1
    AzerothPilotCharDB.completedSteps = {}
    
    AzerothPilot:Print("Started guide: " .. guide.name)
    AzerothPilot:Print("Level range: " .. guide.minLevel .. "-" .. guide.maxLevel)
    
    self:UpdateCurrentStep()
    return true
end

-- Stop current guide
function Engine:StopGuide()
    if not self.activeGuide then
        AzerothPilot:Print("No active guide")
        return
    end
    
    AzerothPilot:Print("Stopped guide: " .. self.activeGuide.name)
    self.activeGuide = nil
    self.currentStepIndex = 1
    
    AzerothPilotCharDB.currentGuide = nil
    
    if AzerothPilot.UI.Arrow then
        AzerothPilot.UI.Arrow:ClearWaypoint()
    end
end

-- Update current step display
function Engine:UpdateCurrentStep()
    if not self.activeGuide then
        return
    end
    
    local step = self:GetCurrentStep()
    if not step then
        AzerothPilot:Print("Guide completed!")
        return
    end
    
    -- Update UI
    if AzerothPilot.UI.MainFrame then
        AzerothPilot.UI.MainFrame:UpdateStep(step)
    end
    
    -- Update arrow
    if step.waypoint and AzerothPilot.UI.Arrow then
        AzerothPilot.UI.Arrow:SetWaypoint({
            x = step.waypoint.x,
            y = step.waypoint.y,
            title = step.title or "Objective"
        })
    end
    
    AzerothPilot:DebugPrint("Step " .. self.currentStepIndex .. "/" .. #self.activeGuide.steps)
end

-- Get current step
function Engine:GetCurrentStep()
    if not self.activeGuide then
        return nil
    end
    
    return self.activeGuide.steps[self.currentStepIndex]
end

-- Advance to next step
function Engine:NextStep()
    if not self.activeGuide then
        return false
    end
    
    if self.currentStepIndex < #self.activeGuide.steps then
        table.insert(AzerothPilotCharDB.completedSteps, self.currentStepIndex)
        self.currentStepIndex = self.currentStepIndex + 1
        AzerothPilotCharDB.currentStep = self.currentStepIndex
        
        self:UpdateCurrentStep()
        
        if AzerothPilotDB.soundEnabled then
            PlaySound(SOUNDKIT.ALARM_CLOCK_WARNING_3)
        end
        
        return true
    else
        AzerothPilot:Print("Guide completed! You're ready for the next zone!")
        return false
    end
end

-- Go to previous step
function Engine:PreviousStep()
    if not self.activeGuide then
        return false
    end
    
    if self.currentStepIndex > 1 then
        self.currentStepIndex = self.currentStepIndex - 1
        AzerothPilotCharDB.currentStep = self.currentStepIndex
        
        -- Remove from completed if it was there
        for i, step in ipairs(AzerothPilotCharDB.completedSteps) do
            if step == self.currentStepIndex then
                table.remove(AzerothPilotCharDB.completedSteps, i)
                break
            end
        end
        
        self:UpdateCurrentStep()
        return true
    end
    
    return false
end

-- Quest event handlers
function Engine:OnQuestAccepted(questID)
    AzerothPilot:DebugPrint("Quest accepted: " .. questID)
    -- Auto-advance if current step is about accepting this quest
    local step = self:GetCurrentStep()
    if step and step.action == "accept" and step.questID == questID then
        self:NextStep()
    end
end

function Engine:OnQuestTurnedIn(questID)
    AzerothPilot:DebugPrint("Quest turned in: " .. questID)
    -- Auto-advance if current step is about turning in this quest
    local step = self:GetCurrentStep()
    if step and step.action == "turnin" and step.questID == questID then
        self:NextStep()
    end
end

function Engine:OnQuestRemoved(questID)
    AzerothPilot:DebugPrint("Quest removed: " .. questID)
end

function Engine:OnLevelUp(level)
    AzerothPilot:Print("Congratulations on level " .. level .. "!")
end

function Engine:OnZoneChanged()
    local zone = AzerothPilot.Utils:GetZoneName()
    AzerothPilot:DebugPrint("Zone changed to: " .. zone)
end
