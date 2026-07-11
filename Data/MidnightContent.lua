-- QuestMaster Pro - Midnight and Revelations content catalog
-- This file intentionally contains only verified zone metadata. Quest IDs and
-- routes should be added only after they are confirmed in the live client.

AzerothPilot.Data.Midnight = AzerothPilot.Data.Midnight or {}
local Midnight = AzerothPilot.Data.Midnight

Midnight.expansion = "Midnight"
Midnight.contentPatch = "12.0.7 Revelations"
Midnight.levelCap = 90

Midnight.zones = {
    { key = "silvermoon_city", name = "Silvermoon City", kind = "capital" },
    { key = "eversong_woods", name = "Eversong Woods", kind = "leveling" },
    { key = "zulaman", name = "Zul'Aman", kind = "leveling" },
    { key = "harandar", name = "Harandar", kind = "leveling" },
    { key = "voidstorm", name = "Voidstorm", kind = "endgame" },
}

function Midnight:Initialize()
    AzerothPilot:DebugPrint(string.format(
        "%s content catalog loaded with %d verified zones",
        self.contentPatch,
        #self.zones
    ))
end

function Midnight:GetZone(key)
    for _, zone in ipairs(self.zones) do
        if zone.key == key then
            return zone
        end
    end

    return nil
end

function Midnight:GetZonesByKind(kind)
    local matches = {}

    for _, zone in ipairs(self.zones) do
        if zone.kind == kind then
            table.insert(matches, zone)
        end
    end

    return matches
end

