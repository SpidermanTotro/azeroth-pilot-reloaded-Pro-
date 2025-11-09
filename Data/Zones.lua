-- Azeroth Pilot Reloaded Pro - Zone Data
-- Comprehensive zone information for all expansions
-- Updated for 2025 - ahead of competitors!

AzerothPilot.Data.Zones = {}
local Zones = AzerothPilot.Data.Zones

-- Classic Zones
Zones.Classic = {
    -- Alliance Starting Zones
    [1426] = { id = 1426, name = "Dun Morogh", faction = "Alliance", level = "1-10", continent = "Eastern Kingdoms" },
    [1429] = { id = 1429, name = "Elwynn Forest", faction = "Alliance", level = "1-10", continent = "Eastern Kingdoms" },
    [1950] = { id = 1950, name = "Teldrassil", faction = "Alliance", level = "1-10", continent = "Kalimdor" },
    [1943] = { id = 1943, name = "Azuremyst Isle", faction = "Alliance", level = "1-10", continent = "Kalimdor" },
    
    -- Horde Starting Zones
    [1411] = { id = 1411, name = "Durotar", faction = "Horde", level = "1-10", continent = "Kalimdor" },
    [1412] = { id = 1412, name = "Mulgore", faction = "Horde", level = "1-10", continent = "Kalimdor" },
    [1420] = { id = 1420, name = "Tirisfal Glades", faction = "Horde", level = "1-10", continent = "Eastern Kingdoms" },
    [1941] = { id = 1941, name = "Eversong Woods", faction = "Horde", level = "1-10", continent = "Eastern Kingdoms" },
    
    -- Mid-level Zones
    [1436] = { id = 1436, name = "Westfall", faction = "Alliance", level = "10-20", continent = "Eastern Kingdoms" },
    [1413] = { id = 1413, name = "The Barrens", faction = "Horde", level = "10-25", continent = "Kalimdor" },
    [1437] = { id = 1437, name = "Wetlands", faction = "Alliance", level = "20-25", continent = "Eastern Kingdoms" },
    [1418] = { id = 1418, name = "Hillsbrad Foothills", faction = "Contested", level = "20-30", continent = "Eastern Kingdoms" },
}

-- The Burning Crusade Zones
Zones.TBC = {
    [1941] = { id = 1941, name = "Eversong Woods", level = "1-10", continent = "Outland" },
    [1943] = { id = 1943, name = "Azuremyst Isle", level = "1-10", continent = "Outland" },
    [1944] = { id = 1944, name = "Hellfire Peninsula", level = "58-63", continent = "Outland" },
    [1946] = { id = 1946, name = "Zangarmarsh", level = "60-64", continent = "Outland" },
    [1947] = { id = 1947, name = "Terokkar Forest", level = "62-65", continent = "Outland" },
    [1948] = { id = 1948, name = "Nagrand", level = "64-67", continent = "Outland" },
    [1949] = { id = 1949, name = "Blade's Edge Mountains", level = "65-68", continent = "Outland" },
    [1951] = { id = 1951, name = "Netherstorm", level = "67-70", continent = "Outland" },
    [1952] = { id = 1952, name = "Shadowmoon Valley", level = "67-70", continent = "Outland" },
}

-- Wrath of the Lich King Zones
Zones.WotLK = {
    [1464] = { id = 1464, name = "Borean Tundra", level = "68-72", continent = "Northrend" },
    [1465] = { id = 1465, name = "Howling Fjord", level = "68-72", continent = "Northrend" },
    [1466] = { id = 1466, name = "Dragonblight", level = "71-74", continent = "Northrend" },
    [1467] = { id = 1467, name = "Grizzly Hills", level = "73-75", continent = "Northrend" },
    [1468] = { id = 1468, name = "Zul'Drak", level = "74-77", continent = "Northrend" },
    [1469] = { id = 1469, name = "Sholazar Basin", level = "75-78", continent = "Northrend" },
    [1470] = { id = 1470, name = "Icecrown", level = "77-80", continent = "Northrend" },
    [1471] = { id = 1471, name = "Storm Peaks", level = "76-80", continent = "Northrend" },
}

-- Cataclysm Zones
Zones.Cataclysm = {
    [1527] = { id = 1527, name = "Mount Hyjal", level = "80-82", continent = "Kalimdor" },
    [1528] = { id = 1528, name = "Vashj'ir", level = "80-82", continent = "Eastern Kingdoms" },
    [1529] = { id = 1529, name = "Deepholm", level = "82-83", continent = "Maelstrom" },
    [1530] = { id = 1530, name = "Uldum", level = "83-84", continent = "Kalimdor" },
    [1531] = { id = 1531, name = "Twilight Highlands", level = "84-85", continent = "Eastern Kingdoms" },
}

-- Mists of Pandaria Zones (FRESH CONTENT - 2025!)
Zones.Pandaria = {
    [1504] = { id = 1504, name = "The Jade Forest", level = "80-85", continent = "Pandaria", expansion = "Mists of Pandaria" },
    [1530] = { id = 1530, name = "Valley of the Four Winds", level = "85-86", continent = "Pandaria", expansion = "Mists of Pandaria" },
    [1524] = { id = 1524, name = "Krasarang Wilds", level = "85-86", continent = "Pandaria", expansion = "Mists of Pandaria" },
    [1533] = { id = 1533, name = "Kun-Lai Summit", level = "87-88", continent = "Pandaria", expansion = "Mists of Pandaria" },
    [1534] = { id = 1534, name = "Townlong Steppes", level = "88-89", continent = "Pandaria", expansion = "Mists of Pandaria" },
    [1535] = { id = 1535, name = "Dread Wastes", level = "89-90", continent = "Pandaria", expansion = "Mists of Pandaria" },
    [1554] = { id = 1554, name = "Timeless Isle", level = "90", continent = "Pandaria", expansion = "Mists of Pandaria" },
    [1530] = { id = 1530, name = "Vale of Eternal Blossoms", level = "90", continent = "Pandaria", expansion = "Mists of Pandaria" },
}

-- Get zone info by ID
function Zones:GetZone(zoneID)
    for _, expansion in pairs(Zones) do
        if type(expansion) == "table" and expansion[zoneID] then
            return expansion[zoneID]
        end
    end
    return nil
end

-- Get zones by expansion
function Zones:GetZonesByExpansion(expansion)
    return Zones[expansion] or {}
end

-- Get recommended zone for level
function Zones:GetRecommendedZone(level, faction)
    -- This is a simple implementation - can be expanded
    if level <= 10 then
        return "Starting Zone"
    elseif level <= 20 then
        return "Westfall/Barrens"
    elseif level <= 30 then
        return "Duskwood/Hillsbrad"
    elseif level <= 40 then
        return "Stranglethorn Vale"
    elseif level <= 50 then
        return "Tanaris/Hinterlands"
    elseif level <= 60 then
        return "Western/Eastern Plaguelands"
    elseif level <= 70 then
        return "Outland"
    elseif level <= 80 then
        return "Northrend"
    elseif level <= 85 then
        return "Cataclysm zones or Pandaria"
    elseif level <= 90 then
        return "Pandaria"
    else
        return "Max level content"
    end
end
