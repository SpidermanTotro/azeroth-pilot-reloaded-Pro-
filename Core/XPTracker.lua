-- XPTracker.lua - XP per Minute Optimizer and Leveling Speed Tracker
-- Tracks leveling speed and provides time-to-level estimates

QuestMasterPro.XPTracker = QuestMasterPro.XPTracker or {}

local XPTracker = QuestMasterPro.XPTracker

-- Configuration
XPTracker.config = {
    trackXPRate = true,
    showTimeToLevel = true,
    showSessionStats = true,
    updateInterval = 5, -- Update every 5 seconds
    resetOnLevel = true,
}

-- Session data
XPTracker.session = {
    startTime = 0,
    startXP = 0,
    startLevel = 0,
    currentXPRate = 0, -- XP per minute
    totalXPGained = 0,
    questsCompleted = 0,
    mobsKilled = 0,
    deaths = 0,
}

-- Display frame
XPTracker.frame = nil

-- Initialize session
function XPTracker:StartSession()
    self.session.startTime = GetTime()
    self.session.startXP = UnitXP("player")
    self.session.startLevel = UnitLevel("player")
    self.session.totalXPGained = 0
    self.session.questsCompleted = 0
    self.session.mobsKilled = 0
    self.session.deaths = 0

    print("|cff00ff00[QuestMaster Pro]|r XP Tracking session started!")
end

-- Calculate current XP per minute
function XPTracker:CalculateXPRate()
    if not self.config.trackXPRate then return 0 end

    local currentTime = GetTime()
    local elapsedTime = currentTime - self.session.startTime

    if elapsedTime < 1 then return 0 end

    local currentXP = UnitXP("player")
    local currentLevel = UnitLevel("player")

    -- Account for level ups
    local totalXP = self.session.totalXPGained
    if currentLevel > self.session.startLevel then
        -- Player leveled up, add previous level's max XP
        totalXP = totalXP + (UnitXPMax("player") - self.session.startXP) + currentXP
    else
        totalXP = currentXP - self.session.startXP
    end

    -- Calculate XP per minute
    local elapsedMinutes = elapsedTime / 60
    local xpPerMin = totalXP / elapsedMinutes

    self.session.currentXPRate = xpPerMin
    self.session.totalXPGained = totalXP

    return xpPerMin
end

-- Estimate time to next level
function XPTracker:EstimateTimeToLevel()
    if not self.config.showTimeToLevel then return 0, "N/A" end

    local currentXP = UnitXP("player")
    local maxXP = UnitXPMax("player")
    local remainingXP = maxXP - currentXP

    local xpRate = self:CalculateXPRate()

    if xpRate <= 0 then
        return 0, "Calculating..."
    end

    local minutesToLevel = remainingXP / xpRate
    local hours = math.floor(minutesToLevel / 60)
    local minutes = math.floor(minutesToLevel % 60)

    if hours > 0 then
        return minutesToLevel, string.format("%dh %dm", hours, minutes)
    else
        return minutesToLevel, string.format("%dm", minutes)
    end
end

-- Create display frame
function XPTracker:CreateDisplayFrame()
    if self.frame then return self.frame end

    local frame = CreateFrame("Frame", "QMPXPTrackerFrame", UIParent)
    frame:SetSize(300, 120)
    frame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -10, 200)
    frame:SetFrameStrata("MEDIUM")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    -- Background
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints()
    frame.bg:SetColorTexture(0, 0, 0, 0.7)

    -- Border
    frame.border = CreateFrame("Frame", nil, frame, "DialogBorderOpaqueTemplate")

    -- Title
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOP", 0, -10)
    frame.title:SetText("XP Tracker")
    frame.title:SetTextColor(0, 1, 1)

    -- XP Rate text
    frame.xpRate = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.xpRate:SetPoint("TOPLEFT", 15, -35)
    frame.xpRate:SetJustifyH("LEFT")
    frame.xpRate:SetText("XP/Hour: Calculating...")

    -- Time to level text
    frame.timeToLevel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.timeToLevel:SetPoint("TOPLEFT", 15, -55)
    frame.timeToLevel:SetJustifyH("LEFT")
    frame.timeToLevel:SetText("Time to Level: Calculating...")

    -- Session stats
    frame.sessionStats = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.sessionStats:SetPoint("TOPLEFT", 15, -75)
    frame.sessionStats:SetJustifyH("LEFT")
    frame.sessionStats:SetText("Session: 0 XP, 0 quests")

    -- Close button
    frame.closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    frame.closeBtn:SetPoint("TOPRIGHT", -5, -5)
    frame.closeBtn:SetScript("OnClick", function()
        frame:Hide()
        XPTracker.config.showSessionStats = false
    end)

    self.frame = frame
    return frame
end

-- Update display
function XPTracker:UpdateDisplay()
    if not self.frame or not self.frame:IsShown() then return end

    local xpRate = self:CalculateXPRate()
    local xpPerHour = xpRate * 60

    -- Update XP rate
    self.frame.xpRate:SetText(string.format("XP/Hour: |cff00ff00%.0f|r (%.0f/min)", xpPerHour, xpRate))

    -- Update time to level
    local _, timeStr = self:EstimateTimeToLevel()
    local percentComplete = (UnitXP("player") / UnitXPMax("player")) * 100
    self.frame.timeToLevel:SetText(string.format(
        "Time to Level: |cff00ffff%s|r (%.1f%%)",
        timeStr,
        percentComplete
    ))

    -- Update session stats
    local sessionTime = GetTime() - self.session.startTime
    local sessionMinutes = math.floor(sessionTime / 60)
    self.frame.sessionStats:SetText(string.format(
        "Session (%dm): |cffffaa00%d XP|r, |cff00ff00%d quests|r, |cffff0000%d deaths|r",
        sessionMinutes,
        self.session.totalXPGained,
        self.session.questsCompleted,
        self.session.deaths
    ))
end

-- Periodic update
function XPTracker:PeriodicUpdate()
    self:CalculateXPRate()
    self:UpdateDisplay()
end

-- Show tracker
function XPTracker:Show()
    local frame = self:CreateDisplayFrame()
    frame:Show()
    self.config.showSessionStats = true
end

-- Hide tracker
function XPTracker:Hide()
    if self.frame then
        self.frame:Hide()
    end
    self.config.showSessionStats = false
end

-- Toggle tracker
function XPTracker:Toggle()
    if self.frame and self.frame:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end

-- Print session summary
function XPTracker:PrintSessionSummary()
    local sessionTime = GetTime() - self.session.startTime
    local sessionMinutes = sessionTime / 60
    local sessionHours = sessionMinutes / 60

    print("|cff00ff00[QuestMaster Pro]|r Session Summary:")
    print(string.format("  Duration: %.1f hours (%.0f minutes)", sessionHours, sessionMinutes))
    print(string.format("  XP Gained: |cffffaa00%d|r", self.session.totalXPGained))
    print(string.format("  XP/Hour: |cff00ff00%.0f|r", self.session.currentXPRate * 60))
    print(string.format("  Quests Completed: |cff00ff00%d|r", self.session.questsCompleted))
    print(string.format("  Mobs Killed: |cff00ff00%d|r", self.session.mobsKilled))
    if self.session.deaths > 0 then
        print(string.format("  Deaths: |cffff0000%d|r (Ouch!)", self.session.deaths))
    end
end

-- Initialize
function XPTracker:Initialize()
    print("|cff00ff00[QuestMaster Pro]|r XP Tracker loaded!")

    self:StartSession()

    -- Create update ticker
    C_Timer.NewTicker(self.config.updateInterval, function()
        XPTracker:PeriodicUpdate()
    end)

    -- Event tracking
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_XP_UPDATE")
    frame:RegisterEvent("PLAYER_LEVEL_UP")
    frame:RegisterEvent("QUEST_TURNED_IN")
    frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    frame:RegisterEvent("PLAYER_DEAD")

    frame:SetScript("OnEvent", function(_, event, ...)
        if event == "PLAYER_LEVEL_UP" then
            local newLevel = ...

            if XPTracker.config.resetOnLevel then
                -- Print summary before reset
                XPTracker:PrintSessionSummary()

                -- Congratulate
                print(string.format("|cff00ff00[DING!]|r Congratulations on level %d!", newLevel))

                -- Reset session
                XPTracker:StartSession()
            end

        elseif event == "QUEST_TURNED_IN" then
            XPTracker.session.questsCompleted = XPTracker.session.questsCompleted + 1

        elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
            local _, subEvent, _, sourceGUID = CombatLogGetCurrentEventInfo()
            if subEvent == "PARTY_KILL" and sourceGUID == UnitGUID("player") then
                XPTracker.session.mobsKilled = XPTracker.session.mobsKilled + 1
            end

        elseif event == "PLAYER_DEAD" then
            XPTracker.session.deaths = XPTracker.session.deaths + 1
        end
    end)

    -- Show tracker if configured
    if self.config.showSessionStats then
        self:Show()
    end
end

-- Slash commands
SLASH_QMPXP1 = "/qmpxp"
SLASH_QMPXP2 = "/xptrack"
SlashCmdList["QMPXP"] = function(msg)
    if msg == "show" then
        XPTracker:Show()
    elseif msg == "hide" then
        XPTracker:Hide()
    elseif msg == "toggle" then
        XPTracker:Toggle()
    elseif msg == "reset" then
        XPTracker:StartSession()
        print("|cff00ff00[QuestMaster Pro]|r XP tracking session reset!")
    elseif msg == "summary" then
        XPTracker:PrintSessionSummary()
    else
        print("|cff00ff00[QuestMaster Pro XP Tracker]|r Commands:")
        print("  /xptrack show - Show XP tracker")
        print("  /xptrack hide - Hide XP tracker")
        print("  /xptrack toggle - Toggle XP tracker")
        print("  /xptrack reset - Reset session stats")
        print("  /xptrack summary - Show session summary")
    end
end

return XPTracker
