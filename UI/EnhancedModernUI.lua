-- EnhancedModernUI.lua - Premium Visual Upgrade for QuestMaster Pro
-- STUNNING 2025 design that CRUSHES Zygor's outdated 2015 interface!

local QMP = QuestMasterPro
QMP.UI = QMP.UI or {}
QMP.UI.Enhanced = {}

-- Premium Color Palette (Better than Zygor's boring brown/grey!)
QMP.UI.Enhanced.Colors = {
    -- Primary Colors
    primary = {r = 0.2, g = 0.4, b = 0.8, a = 1.0},      -- Deep blue
    secondary = {r = 0.8, g = 0.6, b = 0.2, a = 1.0},    -- Rich gold
    accent = {r = 0.4, g = 0.8, b = 1.0, a = 1.0},       -- Bright cyan

    -- Background Colors (Glassmorphism!)
    bgDark = {r = 0.05, g = 0.05, b = 0.1, a = 0.95},
    bgMedium = {r = 0.1, g = 0.15, b = 0.25, a = 0.9},
    bgLight = {r = 0.15, g = 0.2, b = 0.3, a = 0.85},

    -- Semantic Colors
    success = {r = 0.2, g = 0.8, b = 0.3, a = 1.0},
    warning = {r = 0.95, g = 0.7, b = 0.1, a = 1.0},
    error = {r = 0.9, g = 0.2, b = 0.2, a = 1.0},
    info = {r = 0.3, g = 0.7, b = 0.95, a = 1.0},

    -- Text Colors
    textPrimary = {r = 1.0, g = 1.0, b = 1.0, a = 1.0},
    textSecondary = {r = 0.8, g = 0.8, b = 0.9, a = 1.0},
    textMuted = {r = 0.5, g = 0.5, b = 0.6, a = 1.0},
}

-- Animation System (Zygor has ZERO animations!)
QMP.UI.Enhanced.Animations = {
    fadeIn = function(frame, duration)
        frame:SetAlpha(0)
        UIFrameFadeIn(frame, duration or 0.3, 0, 1)
    end,

    fadeOut = function(frame, duration)
        UIFrameFadeOut(frame, duration or 0.3, 1, 0)
    end,

    slideIn = function(frame, direction, duration)
        -- Slide from direction: "left", "right", "top", "bottom"
        local startX, startY = 0, 0
        if direction == "left" then startX = -200
        elseif direction == "right" then startX = 200
        elseif direction == "top" then startY = 200
        elseif direction == "bottom" then startY = -200 end

        frame:SetPoint("CENTER", UIParent, "CENTER", startX, startY)
        frame:SetAlpha(0)

        C_Timer.After(0.01, function()
            frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
            QMP.UI.Enhanced.Animations.fadeIn(frame, duration or 0.5)
        end)
    end,

    pulse = function(frame, scale, duration)
        -- Pulsing animation (like rare mob alerts!)
        scale = scale or 1.1
        duration = duration or 0.8

        local originalScale = frame:GetScale()
        frame:SetScript("OnUpdate", function(_, elapsed)
            local time = GetTime()
            local pulseScale = originalScale + (math.sin(time * (2 * math.pi / duration)) * (scale - originalScale))
            frame:SetScale(pulseScale)
        end)
    end,

    glow = function(frame, color, intensity)
        -- Add glowing border effect
        if not frame.glowTexture then
            frame.glowTexture = frame:CreateTexture(nil, "OVERLAY")
            frame.glowTexture:SetTexture("Interface\\AddOns\\QuestMasterPro\\Textures\\Glow")
            frame.glowTexture:SetAllPoints(frame)
            frame.glowTexture:SetBlendMode("ADD")
        end

        color = color or QMP.UI.Enhanced.Colors.accent
        intensity = intensity or 0.5
        frame.glowTexture:SetVertexColor(color.r, color.g, color.b, intensity)
    end,

    sparkle = function(frame)
        -- Particle sparkle effect for level-ups!
        local particles = {}
        for i = 1, 20 do
            local particle = frame:CreateTexture(nil, "OVERLAY")
            particle:SetTexture("Interface\\Cooldown\\star4")
            particle:SetSize(16, 16)
            particle:SetBlendMode("ADD")

            local angle = math.random() * 2 * math.pi
            local distance = math.random(50, 150)
            local x = math.cos(angle) * distance
            local y = math.sin(angle) * distance

            particle:SetPoint("CENTER", frame, "CENTER", 0, 0)
            particle:SetAlpha(1)

            C_Timer.After(0.01, function()
                particle:SetPoint("CENTER", frame, "CENTER", x, y)
                UIFrameFadeOut(particle, 1.5, 1, 0)
            end)

            C_Timer.After(1.5, function()
                particle:Hide()
            end)
        end
    end
}

-- Premium Circular XP Tracker (WAY better than Zygor's basic bar!)
function QMP.UI.Enhanced:CreateCircularXPTracker()
    local frame = CreateFrame("Frame", "QMP_CircularXPTracker", UIParent)
    frame:SetSize(120, 120)
    frame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -20, -20)
    frame:SetFrameStrata("HIGH")

    -- Background circle
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints()
    frame.bg:SetTexture("Interface\\AddOns\\QuestMasterPro\\Textures\\CircleBG")
    frame.bg:SetVertexColor(0.1, 0.1, 0.2, 0.9)

    -- Progress circle (animated!)
    frame.progress = frame:CreateTexture(nil, "ARTWORK")
    frame.progress:SetAllPoints()
    frame.progress:SetTexture("Interface\\AddOns\\QuestMasterPro\\Textures\\CircleProgress")
    frame.progress:SetVertexColor(0.2, 0.6, 1.0, 1.0)

    -- Center text (level)
    frame.levelText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    frame.levelText:SetPoint("CENTER", 0, 10)
    frame.levelText:SetText(UnitLevel("player"))
    frame.levelText:SetTextColor(1, 1, 1, 1)

    -- XP percentage
    frame.xpText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.xpText:SetPoint("CENTER", 0, -10)
    frame.xpText:SetText("0%")
    frame.xpText:SetTextColor(0.8, 0.8, 0.9, 1)

    -- ETA text
    frame.etaText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.etaText:SetPoint("TOP", frame, "BOTTOM", 0, -5)
    frame.etaText:SetText("ETA: Calculating...")
    frame.etaText:SetTextColor(0.6, 0.6, 0.7, 1)

    -- Glow effect
    QMP.UI.Enhanced.Animations.glow(frame, QMP.UI.Enhanced.Colors.primary, 0.3)

    -- Update function
    frame:SetScript("OnUpdate", function(f, elapsed)
        local currentXP = UnitXP("player")
        local maxXP = UnitXPMax("player")
        local percent = (currentXP / maxXP) * 100

        f.xpText:SetText(string.format("%.1f%%", percent))

        -- Animate progress circle (rotate based on %)
        local rotation = (percent / 100) * 360
        -- Set texture coordinates for rotation (simplified)
        f.progress:SetRotation(math.rad(rotation))

        -- Update ETA from XP tracker
        if QMP.Core and QMP.Core.XPTracker and QMP.Core.XPTracker.GetTimeToLevel then
            local eta = QMP.Core.XPTracker:GetTimeToLevel()
            if eta then
                f.etaText:SetText("ETA: " .. eta)
            end
        end
    end)

    -- Fade in on create
    QMP.UI.Enhanced.Animations.fadeIn(frame, 0.5)

    return frame
end

-- Toast Notification System (Beautiful popups!)
function QMP.UI.Enhanced:ShowNotification(message, type, icon, duration)
    type = type or "info"
    duration = duration or 3

    local frame = CreateFrame("Frame", nil, UIParent)
    frame:SetSize(300, 60)
    frame:SetPoint("TOP", UIParent, "TOP", 0, -100)
    frame:SetFrameStrata("DIALOG")

    -- Background with gradient
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints()
    frame.bg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")

    local color = QMP.UI.Enhanced.Colors.info
    if type == "success" then color = QMP.UI.Enhanced.Colors.success
    elseif type == "warning" then color = QMP.UI.Enhanced.Colors.warning
    elseif type == "error" then color = QMP.UI.Enhanced.Colors.error end

    frame.bg:SetVertexColor(color.r, color.g, color.b, 0.9)

    -- Border
    frame.border = frame:CreateTexture(nil, "BORDER")
    frame.border:SetAllPoints()
    frame.border:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Border")
    frame.border:SetVertexColor(color.r, color.g, color.b, 1.0)

    -- Icon
    if icon then
        frame.icon = frame:CreateTexture(nil, "ARTWORK")
        frame.icon:SetSize(32, 32)
        frame.icon:SetPoint("LEFT", frame, "LEFT", 10, 0)
        frame.icon:SetTexture(icon)
    end

    -- Message text
    frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.text:SetPoint("LEFT", frame.icon or frame, frame.icon and "RIGHT" or "LEFT", 10, 0)
    frame.text:SetPoint("RIGHT", frame, "RIGHT", -10, 0)
    frame.text:SetText(message)
    frame.text:SetTextColor(1, 1, 1, 1)
    frame.text:SetJustifyH("LEFT")

    -- Slide in from top
    QMP.UI.Enhanced.Animations.slideIn(frame, "top", 0.3)

    -- Glow effect
    QMP.UI.Enhanced.Animations.glow(frame, color, 0.4)

    -- Auto-hide after duration
    C_Timer.After(duration, function()
        QMP.UI.Enhanced.Animations.fadeOut(frame, 0.5)
        C_Timer.After(0.5, function()
            frame:Hide()
        end)
    end)

    return frame
end

-- Enhanced Arrow with Glow (Better than basic Zygor arrow!)
function QMP.UI.Enhanced:CreateEnhancedArrow()
    local frame = CreateFrame("Frame", "QMP_EnhancedArrow", UIParent)
    frame:SetSize(64, 64)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 200)
    frame:SetFrameStrata("HIGH")

    -- Glow background
    frame.glow = frame:CreateTexture(nil, "BACKGROUND")
    frame.glow:SetSize(96, 96)
    frame.glow:SetPoint("CENTER")
    frame.glow:SetTexture("Interface\\Cooldown\\star4")
    frame.glow:SetBlendMode("ADD")
    frame.glow:SetVertexColor(0.2, 0.6, 1.0, 0.5)

    -- Pulsing animation for glow
    QMP.UI.Enhanced.Animations.pulse(frame.glow, 1.2, 1.0)

    -- Arrow texture
    frame.arrow = frame:CreateTexture(nil, "ARTWORK")
    frame.arrow:SetAllPoints()
    frame.arrow:SetTexture("Interface\\Minimap\\MiniMap-QuestArrow")
    frame.arrow:SetVertexColor(0.4, 0.8, 1.0, 1.0)

    -- Distance text
    frame.distance = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.distance:SetPoint("TOP", frame, "BOTTOM", 0, -5)
    frame.distance:SetText("0 yards")
    frame.distance:SetTextColor(1, 1, 1, 1)

    -- ETA text
    frame.eta = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.eta:SetPoint("TOP", frame.distance, "BOTTOM", 0, -2)
    frame.eta:SetText("ETA: 0s")
    frame.eta:SetTextColor(0.8, 0.8, 0.9, 1)

    return frame
end

-- Tabbed Settings Panel (Modern interface!)
function QMP.UI.Enhanced:CreateTabbedSettings()
    local frame = CreateFrame("Frame", "QMP_Settings", UIParent)
    frame:SetSize(600, 400)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("DIALOG")
    frame:Hide()

    -- Background
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints()
    frame.bg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
    frame.bg:SetVertexColor(0.05, 0.05, 0.1, 0.95)

    -- Title
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    frame.title:SetPoint("TOP", 0, -20)
    frame.title:SetText("QuestMaster Pro Settings")
    frame.title:SetTextColor(0.4, 0.8, 1.0, 1.0)

    -- Tabs
    frame.tabs = {}
    local tabNames = {"General", "UI", "Guides", "Advanced"}

    for i, name in ipairs(tabNames) do
        local tab = CreateFrame("Button", nil, frame)
        tab:SetSize(140, 30)
        tab:SetPoint("TOPLEFT", 10 + (i-1)*145, -60)

        -- Tab background
        tab.bg = tab:CreateTexture(nil, "BACKGROUND")
        tab.bg:SetAllPoints()
        tab.bg:SetTexture("Interface\\ChatFrame\\ChatFrameTab-BGLeft")
        tab.bg:SetVertexColor(0.1, 0.2, 0.3, 0.8)

        -- Tab text
        tab.text = tab:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        tab.text:SetPoint("CENTER")
        tab.text:SetText(name)

        -- Click handler
        tab:SetScript("OnClick", function()
            for _, t in ipairs(frame.tabs) do
                t.bg:SetVertexColor(0.1, 0.2, 0.3, 0.8)
            end
            tab.bg:SetVertexColor(0.2, 0.4, 0.8, 1.0)
            -- Switch content here
        end)

        -- Hover effect
        tab:SetScript("OnEnter", function()
            tab.bg:SetVertexColor(0.3, 0.5, 0.9, 0.9)
        end)
        tab:SetScript("OnLeave", function()
            if tab.selected then
                tab.bg:SetVertexColor(0.2, 0.4, 0.8, 1.0)
            else
                tab.bg:SetVertexColor(0.1, 0.2, 0.3, 0.8)
            end
        end)

        table.insert(frame.tabs, tab)
    end

    -- Close button
    frame.close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    frame.close:SetPoint("TOPRIGHT", -5, -5)

    -- Fade in animation
    QMP.UI.Enhanced.Animations.fadeIn(frame, 0.3)

    return frame
end

-- Initialize Enhanced UI
function QMP.UI.Enhanced:Init()
    print("|cff4080ff[QuestMaster Pro]|r Enhanced UI loaded! Zygor can't compete with this! 😎")

    -- Create all enhanced elements
    self:CreateCircularXPTracker()
    self:CreateEnhancedArrow()
    self:CreateTabbedSettings()

    -- Show welcome notification
    C_Timer.After(2, function()
        self:ShowNotification(
            "QuestMaster Pro loaded! Better UI than $120/year Zygor - 100% FREE!",
            "success",
            "Interface\\AddOns\\QuestMasterPro\\Textures\\Logo"
        )
    end)
end

-- Export
return QMP.UI.Enhanced
