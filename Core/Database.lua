-- Azeroth Pilot Reloaded Pro - Database Management
-- Handles guide data and quest information

AzerothPilot.Database = {}
local DB = AzerothPilot.Database

-- Guide storage
DB.Guides = {}
DB.CurrentGuide = nil

-- Register a new guide
function DB:RegisterGuide(guideData)
    if not guideData or not guideData.id then
        AzerothPilot:Print("Error: Invalid guide data")
        return false
    end

    self.Guides[guideData.id] = guideData
    AzerothPilot:DebugPrint("Registered guide: " .. guideData.name)
    return true
end

-- Get guide by ID
function DB:GetGuide(guideId)
    return self.Guides[guideId]
end

-- Get all guides
function DB:GetAllGuides()
    local guides = {}
    for _, guide in pairs(self.Guides) do
        table.insert(guides, guide)
    end
    return guides
end

-- Load a guide
function DB:LoadGuide(guideId)
    local guide = self:GetGuide(guideId)
    if not guide then
        AzerothPilot:Print("Guide not found: " .. tostring(guideId))
        return false
    end

    self.CurrentGuide = guide
    AzerothPilotCharDB.currentGuide = guideId
    AzerothPilotCharDB.currentStep = 1

    AzerothPilot:Print("Loaded guide: " .. guide.name)
    return true
end

-- Get current step
function DB:GetCurrentStep()
    if not self.CurrentGuide then
        return nil
    end

    local stepIndex = AzerothPilotCharDB.currentStep or 1
    return self.CurrentGuide.steps[stepIndex]
end

-- Advance to next step
function DB:NextStep()
    if not self.CurrentGuide then
        return false
    end

    local currentStep = AzerothPilotCharDB.currentStep or 1
    table.insert(AzerothPilotCharDB.completedSteps, currentStep)

    if currentStep < #self.CurrentGuide.steps then
        AzerothPilotCharDB.currentStep = currentStep + 1
        AzerothPilot:Print("Step " .. AzerothPilotCharDB.currentStep .. "/" .. #self.CurrentGuide.steps)
        return true
    else
        AzerothPilot:Print("Guide completed!")
        return false
    end
end

-- Check if step is completed
function DB:IsStepCompleted(stepIndex)
    for _, completedStep in ipairs(AzerothPilotCharDB.completedSteps) do
        if completedStep == stepIndex then
            return true
        end
    end
    return false
end
