-- Azeroth Pilot Reloaded Pro - STUNNING Modern UI System
-- BETTER looking than Zygor's $120/year interface!
-- Beautiful, Fresh, Outstanding design that makes users PROUD!

AzerothPilot.UI.Modern = {}
local ModernUI = AzerothPilot.UI.Modern

-- Color Palette - Professional, Modern, Eye-catching
ModernUI.Colors = {
    -- Primary Colors
    primary = {
        main = {0.0, 0.8, 1.0, 1.0}, -- Vibrant Cyan
        light = {0.3, 0.9, 1.0, 1.0},
        dark = {0.0, 0.6, 0.8, 1.0}
    },
    
    -- Accent Colors
    accent = {
        gold = {1.0, 0.85, 0.0, 1.0}, -- Shiny Gold
        green = {0.0, 1.0, 0.4, 1.0}, -- Success Green
        red = {1.0, 0.2, 0.2, 1.0}, -- Alert Red
        purple = {0.8, 0.3, 1.0, 1.0}, -- Epic Purple
        orange = {1.0, 0.5, 0.0, 1.0} -- Warning Orange
    },
    
    -- UI Elements
    background = {
        solid = {0.05, 0.05, 0.08, 0.95}, -- Almost Black with transparency
        gradient_top = {0.1, 0.1, 0.15, 0.98},
        gradient_bottom = {0.05, 0.05, 0.08, 0.98}
    },
    
    text = {
        primary = {1.0, 1.0, 1.0, 1.0}, -- Pure White
        secondary = {0.8, 0.8, 0.85, 1.0}, -- Light Gray
        muted = {0.5, 0.5, 0.55, 1.0}, -- Darker Gray
        highlight = {0.0, 1.0, 0.8, 1.0} -- Cyan Highlight
    },
    
    borders = {
        default = {0.2, 0.2, 0.25, 1.0},
        highlight = {0.0, 0.8, 1.0, 1.0},
        glow = {0.3, 0.9, 1.0, 0.5}
    }
}

-- Custom Fonts - Beautiful Typography
ModernUI.Fonts = {
    huge = "Fonts\\FRIZQT__.TTF", -- 24pt
    large = "Fonts\\FRIZQT__.TTF", -- 18pt
    normal = "Fonts\\ARIALN.TTF", -- 14pt
    small = "Fonts\\ARIALN.TTF", -- 11pt
    tiny = "Fonts\\ARIALN.TTF" -- 9pt
}

-- Create stunning main window
function ModernUI:CreateMainWindow()
    local frame = CreateFrame("Frame", "APRProMainWindow", UIParent, "BackdropTemplate")
    frame:SetSize(480, 600)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetFrameStrata("HIGH")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetClampedToScreen(true)
    
    -- STUNNING Glass-morphism background
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Glues\\Common\\TextPanel-Border",
        tile = false,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    
    -- Beautiful gradient overlay
    local bg = frame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\AddOns\\AzerothPilotReloadedPro\\Textures\\GradientBG")
    bg:SetVertexColor(unpack(self.Colors.background.solid))
    bg:SetGradientAlpha("VERTICAL", 
        unpack(self.Colors.background.gradient_top),
        unpack(self.Colors.background.gradient_bottom))
    
    -- Glowing border effect
    frame:SetBackdropBorderColor(unpack(self.Colors.borders.highlight))
    
    -- Header with gradient
    local header = frame:CreateTexture(nil, "ARTWORK")
    header:SetPoint("TOPLEFT", 8, -8)
    header:SetPoint("TOPRIGHT", -8, -8)
    header:SetHeight(60)
    header:SetTexture("Interface\\AddOns\\AzerothPilotReloadedPro\\Textures\\HeaderGradient")
    header:SetVertexColor(0.0, 0.6, 0.9, 0.4)
    
    -- Logo/Icon (STUNNING)
    local logo = frame:CreateTexture(nil, "OVERLAY")
    logo:SetPoint("TOPLEFT", header, "TOPLEFT", 15, -10)
    logo:SetSize(40, 40)
    logo:SetTexture("Interface\\Icons\\Achievement_Boss_Ragnaros") -- Temporary, would be custom logo
    
    -- Apply circular mask for logo
    logo:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    
    -- Title Text - GORGEOUS Typography
    local title = frame:CreateFontString(nil, "OVERLAY")
    title:SetPoint("LEFT", logo, "RIGHT", 15, 5)
    title:SetFont(self.Fonts.huge, 24, "OUTLINE")
    title:SetText("Azeroth Pilot |cFF00D4FFPro|r")
    title:SetTextColor(1, 1, 1, 1)
    
    -- Subtitle
    local subtitle = frame:CreateFontString(nil, "OVERLAY")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -3)
    subtitle:SetFont(self.Fonts.small, 11, "")
    subtitle:SetText("|cFF888888The Ultimate Free Leveling Guide|r")
    subtitle:SetTextColor(0.8, 0.8, 0.85, 1)
    
    -- Progress Bar - STUNNING animated progress
    local progressBar = self:CreateProgressBar(frame)
    progressBar:SetPoint("TOP", header, "BOTTOM", 0, -15)
    
    -- Step Display - Beautiful card design
    local stepCard = self:CreateStepCard(frame)
    stepCard:SetPoint("TOP", progressBar, "BOTTOM", 0, -20)
    
    -- Action Buttons - Modern glass design
    local buttonContainer = self:CreateButtonContainer(frame)
    buttonContainer:SetPoint("BOTTOM", frame, "BOTTOM", 0, 15)
    
    -- Minimize button
    local minimizeBtn = self:CreateIconButton(frame, "MINIMIZE", 
        "Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    minimizeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -35, -12)
    
    -- Close button - Custom styled
    local closeBtn = self:CreateIconButton(frame, "CLOSE",
        "Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -10, -12)
    closeBtn:SetScript("OnClick", function() frame:Hide() end)
    
    -- Drag to move
    frame:SetScript("OnDragStart", function(f) f:StartMoving() end)
    frame:SetScript("OnDragStop", function(f) f:StopMovingOrSizing() end)
    
    -- Hover glow effect
    frame:SetScript("OnEnter", function(f)
        f:SetBackdropBorderColor(unpack(self.Colors.primary.light))
    end)
    frame:SetScript("OnLeave", function(f)
        f:SetBackdropBorderColor(unpack(self.Colors.borders.highlight))
    end)
    
    self.mainWindow = frame
    return frame
end

-- Create STUNNING Progress Bar
function ModernUI:CreateProgressBar(parent)
    local container = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    container:SetSize(440, 50)
    
    -- Background
    container:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile = false,
        edgeSize = 2,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    container:SetBackdropColor(0.1, 0.1, 0.12, 0.8)
    container:SetBackdropBorderColor(0.2, 0.2, 0.25, 1.0)
    
    -- Progress fill - ANIMATED
    local progress = container:CreateTexture(nil, "ARTWORK")
    progress:SetPoint("LEFT", 2, 0)
    progress:SetHeight(46)
    progress:SetTexture("Interface\\Buttons\\WHITE8X8")
    progress:SetGradientAlpha("HORIZONTAL",
        0.0, 0.7, 1.0, 0.6,  -- Left: Cyan
        0.0, 0.4, 0.8, 0.8)  -- Right: Darker Cyan
    
    -- Shimmer effect overlay
    local shimmer = container:CreateTexture(nil, "OVERLAY")
    shimmer:SetAllPoints(progress)
    shimmer:SetTexture("Interface\\AddOns\\AzerothPilotReloadedPro\\Textures\\Shimmer")
    shimmer:SetBlendMode("ADD")
    shimmer:SetAlpha(0.3)
    
    -- Progress text
    local text = container:CreateFontString(nil, "OVERLAY")
    text:SetPoint("CENTER")
    text:SetFont(self.Fonts.normal, 14, "OUTLINE")
    text:SetText("Step 1 of 150 |cFF00FF00(0%)|r")
    
    -- XP/Level text
    local levelText = container:CreateFontString(nil, "OVERLAY")
    levelText:SetPoint("LEFT", container, "LEFT", 10, 0)
    levelText:SetFont(self.Fonts.small, 11, "")
    levelText:SetText("|cFFFFD700Level 10|r")
    
    local xpText = container:CreateFontString(nil, "OVERLAY")
    xpText:SetPoint("RIGHT", container, "RIGHT", -10, 0)
    xpText:SetFont(self.Fonts.small, 11, "")
    xpText:SetText("|cFF00D4FF+2,500 XP/hr|r")
    
    container.progress = progress
    container.text = text
    container.levelText = levelText
    container.xpText = xpText
    
    -- Animate progress
    local animGroup = progress:CreateAnimationGroup()
    local anim = animGroup:CreateAnimation("Alpha")
    anim:SetDuration(2)
    anim:SetFromAlpha(0.6)
    anim:SetToAlpha(1.0)
    anim:SetSmoothing("IN_OUT")
    animGroup:SetLooping("BOUNCE")
    animGroup:Play()
    
    return container
end

-- Create Beautiful Step Card
function ModernUI:CreateStepCard(parent)
    local card = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    card:SetSize(440, 320)
    
    -- Card background with shadow
    card:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    card:SetBackdropColor(0.08, 0.08, 0.1, 0.95)
    card:SetBackdropBorderColor(0.3, 0.3, 0.35, 0.8)
    
    -- Card header
    local cardHeader = card:CreateTexture(nil, "ARTWORK")
    cardHeader:SetPoint("TOPLEFT", 4, -4)
    cardHeader:SetPoint("TOPRIGHT", -4, -4)
    cardHeader:SetHeight(40)
    cardHeader:SetTexture("Interface\\Buttons\\WHITE8X8")
    cardHeader:SetGradientAlpha("HORIZONTAL",
        0.1, 0.5, 0.8, 0.4,
        0.1, 0.3, 0.6, 0.4)
    
    -- Step number badge
    local badge = card:CreateTexture(nil, "OVERLAY")
    badge:SetPoint("LEFT", cardHeader, "LEFT", 15, 0)
    badge:SetSize(32, 32)
    badge:SetTexture("Interface\\Buttons\\WHITE8X8")
    badge:SetVertexColor(0.0, 0.8, 1.0, 1.0)
    badge:SetTexCoord(0.1, 0.9, 0.1, 0.9) -- Rounded corners effect
    
    local badgeText = card:CreateFontString(nil, "OVERLAY")
    badgeText:SetPoint("CENTER", badge, "CENTER", 0, 0)
    badgeText:SetFont(self.Fonts.large, 16, "OUTLINE")
    badgeText:SetText("1")
    
    -- Step Title - BOLD and beautiful
    local stepTitle = card:CreateFontString(nil, "OVERLAY")
    stepTitle:SetPoint("LEFT", badge, "RIGHT", 12, 0)
    stepTitle:SetPoint("RIGHT", cardHeader, "RIGHT", -15, 0)
    stepTitle:SetFont(self.Fonts.large, 16, "OUTLINE")
    stepTitle:SetJustifyH("LEFT")
    stepTitle:SetText("|cFF00FF00Accept Quest:|r |cFFFFFFFFThe Mission Begins|r")
    
    -- Separator line
    local separator = card:CreateTexture(nil, "ARTWORK")
    separator:SetPoint("TOPLEFT", cardHeader, "BOTTOMLEFT", 10, -5)
    separator:SetPoint("TOPRIGHT", cardHeader, "BOTTOMRIGHT", -10, -5)
    separator:SetHeight(2)
    separator:SetTexture("Interface\\Buttons\\WHITE8X8")
    separator:SetGradientAlpha("HORIZONTAL",
        0.0, 0.8, 1.0, 0.0,
        0.0, 0.8, 1.0, 1.0,
        0.0, 0.8, 1.0, 0.0)
    
    -- Step description - Clean scrollable text
    local descScroll = CreateFrame("ScrollFrame", nil, card, "UIPanelScrollFrameTemplate")
    descScroll:SetPoint("TOPLEFT", separator, "BOTTOMLEFT", -5, -10)
    descScroll:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -25, 10)
    
    local descText = descScroll:CreateFontString(nil, "OVERLAY")
    descText:SetFont(self.Fonts.normal, 13, "")
    descText:SetJustifyH("LEFT")
    descText:SetJustifyV("TOP")
    descText:SetSpacing(4)
    descText:SetText([[
|cFFFFFFFF1.|r Travel to Stormwind City and speak with King Varian

|cFF888888Location:|r Stormwind Keep
|cFF888888Coordinates:|r 85.6, 31.8

|cFFFFD700Tip:|r Use the tram from Ironforge if you haven't discovered Stormwind yet!

|cFF00FF00Objective:|r Accept the quest "The Alliance Needs You!"
]])
    descText:SetWidth(descScroll:GetWidth())
    descScroll:SetScrollChild(descText)
    
    -- Quest Icon indicator
    local questIcon = card:CreateTexture(nil, "OVERLAY")
    questIcon:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 15, 15)
    questIcon:SetSize(24, 24)
    questIcon:SetTexture("Interface\\GossipFrame\\AvailableQuestIcon")
    
    -- Distance indicator (if applicable)
    local distanceText = card:CreateFontString(nil, "OVERLAY")
    distanceText:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -15, 15)
    distanceText:SetFont(self.Fonts.normal, 13, "OUTLINE")
    distanceText:SetText("|cFF00D4FF▶ 245 yards|r")
    
    card.stepTitle = stepTitle
    card.descText = descText
    card.badgeText = badgeText
    card.distanceText = distanceText
    
    return card
end

-- Create Modern Button Container
function ModernUI:CreateButtonContainer(parent)
    local container = CreateFrame("Frame", nil, parent)
    container:SetSize(440, 50)
    
    -- Previous button
    local prevBtn = self:CreateModernButton(container, "◀ Previous", 130)
    prevBtn:SetPoint("LEFT", container, "LEFT", 0, 0)
    prevBtn:SetScript("OnClick", function()
        if AzerothPilot.Guides.Engine.activeGuide then
            AzerothPilot.Guides.Engine:PreviousStep()
        end
    end)
    
    -- Skip button (center)
    local skipBtn = self:CreateModernButton(container, "Skip", 100)
    skipBtn:SetPoint("CENTER", container, "CENTER", 0, 0)
    skipBtn.bg:SetVertexColor(0.8, 0.4, 0.0, 0.8) -- Orange
    skipBtn:SetScript("OnClick", function()
        if AzerothPilot.Guides.Engine.activeGuide then
            AzerothPilot.Guides.Engine:NextStep()
        end
    end)
    
    -- Next button
    local nextBtn = self:CreateModernButton(container, "Next ▶", 130)
    nextBtn:SetPoint("RIGHT", container, "RIGHT", 0, 0)
    nextBtn.bg:SetVertexColor(0.0, 0.8, 0.4, 0.8) -- Green
    nextBtn:SetScript("OnClick", function()
        if AzerothPilot.Guides.Engine.activeGuide then
            AzerothPilot.Guides.Engine:NextStep()
        end
    end)
    
    return container
end

-- Create GORGEOUS Modern Button
function ModernUI:CreateModernButton(parent, text, width)
    local btn = CreateFrame("Button", nil, parent, "BackdropTemplate")
    btn:SetSize(width, 40)
    
    -- Button background
    btn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        tile = false,
        edgeSize = 2,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    
    local bg = btn:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Buttons\\WHITE8X8")
    bg:SetVertexColor(0.0, 0.7, 1.0, 0.8)
    btn.bg = bg
    
    btn:SetBackdropBorderColor(0.0, 0.9, 1.0, 1.0)
    
    -- Button text
    local btnText = btn:CreateFontString(nil, "OVERLAY")
    btnText:SetPoint("CENTER")
    btnText:SetFont(self.Fonts.normal, 14, "OUTLINE")
    btnText:SetText(text)
    btnText:SetTextColor(1, 1, 1, 1)
    
    -- Hover effects
    btn:SetScript("OnEnter", function(self)
        self.bg:SetVertexColor(0.2, 0.9, 1.0, 1.0)
        self:SetBackdropBorderColor(1.0, 1.0, 1.0, 1.0)
    end)
    
    btn:SetScript("OnLeave", function(self)
        self.bg:SetVertexColor(0.0, 0.7, 1.0, 0.8)
        self:SetBackdropBorderColor(0.0, 0.9, 1.0, 1.0)
    end)
    
    -- Click effect
    btn:SetScript("OnMouseDown", function(self)
        self.bg:SetVertexColor(0.0, 0.5, 0.8, 1.0)
    end)
    
    btn:SetScript("OnMouseUp", function(self)
        self.bg:SetVertexColor(0.2, 0.9, 1.0, 1.0)
    end)
    
    return btn
end

-- Create Icon Button
function ModernUI:CreateIconButton(parent, type, texture)
    local btn = CreateFrame("Button", nil, parent)
    btn:SetSize(20, 20)
    
    local icon = btn:CreateTexture(nil, "ARTWORK")
    icon:SetAllPoints()
    icon:SetTexture(texture)
    icon:SetVertexColor(0.8, 0.8, 0.85, 1.0)
    
    btn:SetScript("OnEnter", function()
        icon:SetVertexColor(1.0, 1.0, 1.0, 1.0)
    end)
    
    btn:SetScript("OnLeave", function()
        icon:SetVertexColor(0.8, 0.8, 0.85, 1.0)
    end)
    
    return btn
end

-- Create stunning minimap button
function ModernUI:CreateMinimapButton()
    local btn = CreateFrame("Button", "APRProMinimapButton", Minimap)
    btn:SetSize(32, 32)
    btn:SetFrameStrata("MEDIUM")
    btn:SetFrameLevel(8)
    btn:RegisterForClicks("AnyUp")
    btn:RegisterForDrag("LeftButton")
    btn:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    
    -- Icon
    local icon = btn:CreateTexture(nil, "BACKGROUND")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER", 0, 1)
    icon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
    
    -- Border
    local overlay = btn:CreateTexture(nil, "OVERLAY")
    overlay:SetSize(52, 52)
    overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    overlay:SetPoint("TOPLEFT")
    
    -- Glow effect
    local glow = btn:CreateTexture(nil, "ARTWORK")
    glow:SetSize(28, 28)
    glow:SetPoint("CENTER")
    glow:SetTexture("Interface\\Buttons\\WHITE8X8")
    glow:SetVertexColor(0.0, 0.8, 1.0, 0.3)
    glow:SetBlendMode("ADD")
    
    -- Position on minimap
    btn:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -10, 10)
    
    -- Click handler
    btn:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            if ModernUI.mainWindow:IsShown() then
                ModernUI.mainWindow:Hide()
            else
                ModernUI.mainWindow:Show()
            end
        elseif button == "RightButton" then
            -- Open settings
            AzerothPilot:OpenSettings()
        end
    end)
    
    -- Tooltip
    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText("|cFF00D4FFAzeroth Pilot Pro|r", 1, 1, 1)
        GameTooltip:AddLine("Left-click: Toggle Guide", 0.8, 0.8, 0.85)
        GameTooltip:AddLine("Right-click: Settings", 0.8, 0.8, 0.85)
        GameTooltip:AddLine(" ", 1, 1, 1)
        GameTooltip:AddLine("|cFF00FF00The Ultimate FREE Leveling Guide!|r", 0, 1, 0.5)
        GameTooltip:Show()
    end)
    
    btn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    return btn
end

-- Initialize the STUNNING UI
function ModernUI:Initialize()
    self:CreateMainWindow()
    self:CreateMinimapButton()
    
    AzerothPilot:Print("|cFF00D4FFSTUNNING Modern UI loaded!|r")
    AzerothPilot:Print("|cFFFFD700Interface BETTER than Zygor - 100% FREE!|r")
end

return ModernUI
