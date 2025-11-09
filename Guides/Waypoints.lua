-- Azeroth Pilot Reloaded Pro - Waypoint System
-- Modern waypoint management superior to competitors

AzerothPilot.Guides.Waypoints = {}
local Waypoints = AzerothPilot.Guides.Waypoints

Waypoints.activeWaypoints = {}
Waypoints.waypointPool = {}

-- Initialize waypoint system
function Waypoints:Initialize()
    AzerothPilot:DebugPrint("Waypoint system initialized")
    
    -- Create waypoint pool for map pins
    for i = 1, 10 do
        local pin = CreateFrame("Frame", "APWaypoint" .. i, WorldMapFrame:GetCanvas())
        pin:SetSize(32, 32)
        pin.texture = pin:CreateTexture(nil, "OVERLAY")
        pin.texture:SetAllPoints()
        pin.texture:SetTexture("Interface\\AddOns\\AzerothPilotReloadedPro\\Textures\\Waypoint")
        pin.texture:SetVertexColor(0, 1, 0, 1)
        pin:Hide()
        table.insert(self.waypointPool, pin)
    end
end

-- Add a waypoint
function Waypoints:AddWaypoint(x, y, mapID, title, waypointType)
    local waypoint = {
        x = x,
        y = y,
        mapID = mapID,
        title = title or "Waypoint",
        type = waypointType or "objective",
        timestamp = GetTime()
    }
    
    table.insert(self.activeWaypoints, waypoint)
    self:UpdateMapPins()
    
    AzerothPilot:DebugPrint("Added waypoint: " .. waypoint.title)
    return waypoint
end

-- Remove waypoint
function Waypoints:RemoveWaypoint(index)
    if self.activeWaypoints[index] then
        table.remove(self.activeWaypoints, index)
        self:UpdateMapPins()
        return true
    end
    return false
end

-- Clear all waypoints
function Waypoints:ClearAll()
    self.activeWaypoints = {}
    self:UpdateMapPins()
end

-- Update map pins
function Waypoints:UpdateMapPins()
    -- Hide all pins first
    for _, pin in ipairs(self.waypointPool) do
        pin:Hide()
    end
    
    -- Show active waypoints
    for i, waypoint in ipairs(self.activeWaypoints) do
        if i <= #self.waypointPool then
            local pin = self.waypointPool[i]
            
            -- Set pin position
            pin:SetPoint("CENTER", WorldMapFrame:GetCanvas(), "TOPLEFT", 
                waypoint.x * WorldMapFrame:GetCanvas():GetWidth(),
                -waypoint.y * WorldMapFrame:GetCanvas():GetHeight())
            
            -- Color based on type
            if waypoint.type == "quest" then
                pin.texture:SetVertexColor(1, 1, 0, 1) -- Yellow
            elseif waypoint.type == "turnin" then
                pin.texture:SetVertexColor(0, 1, 0, 1) -- Green
            else
                pin.texture:SetVertexColor(0, 0.8, 1, 1) -- Blue
            end
            
            pin:Show()
        end
    end
end

-- Get nearest waypoint
function Waypoints:GetNearest()
    local playerX, playerY, playerMap = AzerothPilot.Utils:GetPlayerPosition()
    if not playerX then
        return nil
    end
    
    local nearest = nil
    local nearestDist = math.huge
    
    for _, waypoint in ipairs(self.activeWaypoints) do
        if waypoint.mapID == playerMap then
            local dist = AzerothPilot.Utils:GetDistance(playerX, playerY, waypoint.x, waypoint.y)
            if dist < nearestDist then
                nearestDist = dist
                nearest = waypoint
            end
        end
    end
    
    return nearest, nearestDist
end

-- Set TomTom waypoint (if TomTom is installed)
function Waypoints:SetTomTomWaypoint(x, y, mapID, title)
    if TomTom and TomTom.AddWaypoint then
        TomTom:AddWaypoint(mapID, x, y, {
            title = title,
            persistent = false,
            minimap = true,
            world = true
        })
        return true
    end
    return false
end

-- Get all waypoints for current map
function Waypoints:GetCurrentMapWaypoints()
    local _, _, playerMap = AzerothPilot.Utils:GetPlayerPosition()
    if not playerMap then
        return {}
    end
    
    local waypoints = {}
    for _, waypoint in ipairs(self.activeWaypoints) do
        if waypoint.mapID == playerMap then
            table.insert(waypoints, waypoint)
        end
    end
    
    return waypoints
end
