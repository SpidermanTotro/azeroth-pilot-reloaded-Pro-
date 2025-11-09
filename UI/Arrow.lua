-- Azeroth Pilot Reloaded Pro - Navigation Arrow
-- Advanced waypoint arrow system - superior to competitors

AzerothPilot.UI.Arrow = {}
local Arrow = AzerothPilot.UI.Arrow

-- Create the arrow frame
function Arrow:Initialize()
    if self.frame then
        return
    end
    
    self.frame = CreateFrame("Frame", "AzerothPilotArrow", UIParent)
    self.frame:SetSize(64, 64)
    self.frame:SetPoint("TOP", UIParent, "TOP", 0, -150)
    self.frame:SetFrameStrata("HIGH")
    
    -- Arrow texture
    self.texture = self.frame:CreateTexture(nil, "ARTWORK")
    self.texture:SetAllPoints()
    self.texture:SetTexture("Interface\\Minimap\\MinimapArrow")
    
    -- Distance text
    self.distanceText = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    self.distanceText:SetPoint("TOP", self.frame, "BOTTOM", 0, -5)
    self.distanceText:SetText("")
    
    -- Title text
    self.titleText = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    self.titleText:SetPoint("BOTTOM", self.frame, "TOP", 0, 5)
    self.titleText:SetText("")
    
    -- Make it movable
    self.frame:SetMovable(true)
    self.frame:EnableMouse(true)
    self.frame:RegisterForDrag("LeftButton")
    self.frame:SetScript("OnDragStart", function(f) f:StartMoving() end)
    self.frame:SetScript("OnDragStop", function(f) f:StopMovingOrSizing() end)
    
    -- Update timer
    self.frame:SetScript("OnUpdate", function(f, elapsed)
        Arrow:OnUpdate(elapsed)
    end)
    
    self.updateInterval = 0
    self.currentWaypoint = nil
    
    self:UpdateVisibility()
    AzerothPilot:DebugPrint("Arrow initialized")
end

-- Update arrow direction and distance
function Arrow:OnUpdate(elapsed)
    if not self.currentWaypoint then
        return
    end
    
    self.updateInterval = self.updateInterval + elapsed
    if self.updateInterval < 0.1 then
        return
    end
    self.updateInterval = 0
    
    local playerX, playerY = AzerothPilot.Utils:GetPlayerPosition()
    if not playerX then
        return
    end
    
    local wpX = self.currentWaypoint.x
    local wpY = self.currentWaypoint.y
    
    -- Calculate angle
    local angle = math.atan2(wpY - playerY, wpX - playerX)
    local playerFacing = GetPlayerFacing()
    if playerFacing then
        angle = angle - playerFacing
    end
    
    -- Rotate arrow
    self.texture:SetRotation(-angle)
    
    -- Update distance
    local distance = AzerothPilot.Utils:GetDistanceToWaypoint(wpX, wpY)
    if distance then
        -- Convert to yards (approximate)
        local yards = distance * 1000
        if yards < 1000 then
            self.distanceText:SetText(string.format("%.0f yards", yards))
        else
            self.distanceText:SetText(string.format("%.1f km", yards / 1000))
        end
        
        -- Change color based on distance
        if yards < 50 then
            self.distanceText:SetTextColor(0, 1, 0) -- Green - very close
        elseif yards < 200 then
            self.distanceText:SetTextColor(1, 1, 0) -- Yellow - close
        else
            self.distanceText:SetTextColor(1, 1, 1) -- White - far
        end
    end
end

-- Set waypoint
function Arrow:SetWaypoint(waypoint)
    if not waypoint or not waypoint.x or not waypoint.y then
        self.currentWaypoint = nil
        self.titleText:SetText("")
        self.distanceText:SetText("")
        return
    end
    
    self.currentWaypoint = waypoint
    self.titleText:SetText(waypoint.title or "Waypoint")
    AzerothPilot:DebugPrint("Arrow set to: " .. (waypoint.title or "waypoint"))
end

-- Clear waypoint
function Arrow:ClearWaypoint()
    self:SetWaypoint(nil)
end

-- Update visibility
function Arrow:UpdateVisibility()
    if not self.frame then
        return
    end
    
    if AzerothPilotDB.showArrow and self.currentWaypoint then
        self.frame:Show()
    else
        self.frame:Hide()
    end
end

-- Set scale
function Arrow:SetScale(scale)
    if self.frame then
        self.frame:SetScale(scale or 1.0)
    end
end
