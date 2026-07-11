-- QuestMaster Pro - client and content-patch compatibility

AzerothPilot.PatchCompatibility = AzerothPilot.PatchCompatibility or {}
local Patch = AzerothPilot.PatchCompatibility

function Patch:Refresh()
    local version, build, buildDate, interfaceVersion = GetBuildInfo()

    self.version = version or "Unknown"
    self.build = build or "Unknown"
    self.buildDate = buildDate or "Unknown"
    self.interfaceVersion = tonumber(interfaceVersion) or 0
    self.isMidnight = self.interfaceVersion >= 120000 and self.interfaceVersion < 130000
    self.isRevelations = self.interfaceVersion >= 120007 and self.interfaceVersion < 130000

    return self
end

function Patch:GetContentLabel()
    if self.isRevelations then
        return "Midnight: Revelations"
    elseif self.isMidnight then
        return "Midnight"
    end

    return "Legacy/Classic client"
end

function Patch:IsSupportedRetailClient()
    return self.interfaceVersion >= 120000 and self.interfaceVersion < 130000
end

function Patch:Initialize()
    self:Refresh()
    AzerothPilot:DebugPrint(string.format(
        "Client %s (interface %d) - %s",
        self.version,
        self.interfaceVersion,
        self:GetContentLabel()
    ))
end

Patch:Refresh()

