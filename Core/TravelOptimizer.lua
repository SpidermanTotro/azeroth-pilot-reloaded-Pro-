-- TravelOptimizer.lua - Auto Hearth & Flight Path System
-- Automatically suggests hearthstone locations and optimizes flight paths

QuestMasterPro.Travel = QuestMasterPro.Travel or {}

local Travel = QuestMasterPro.Travel

-- Configuration
Travel.config = {
    hearthReminderInterval = 300, -- 5 minutes
    autoSuggestFlightPaths = true,
    trackHearthCooldown = true,
    notifyOnHearthReady = true,
}

-- Data storage
Travel.data = {
    lastHearthCheck = 0,
    suggestedHearthLocation = nil,
    knownFlightPaths = {},
    currentHub = nil,
}

-- Optimal hearth locations by zone
Travel.optimalHearths = {
    -- Classic Alliance
    ["Elwynn Forest"] = {location = "Goldshire", coords = {42.1, 65.9}, innkeeper = "Innkeeper Farley"},
    ["Westfall"] = {location = "Sentinel Hill", coords = {56.6, 47.6}, innkeeper = "Innkeeper Heather"},
    ["Redridge Mountains"] = {location = "Lakeshire", coords = {26.4, 41.4}, innkeeper = "Innkeeper Brianna"},
    ["Duskwood"] = {location = "Darkshire", coords = {73.9, 44.4}, innkeeper = "Innkeeper Trelayne"},
    ["Stranglethorn Vale"] = {location = "Booty Bay", coords = {27.0, 77.2}, innkeeper = "Innkeeper Skindle"},

    -- Classic Horde
    ["Durotar"] = {location = "Razor Hill", coords = {51.6, 41.6}, innkeeper = "Innkeeper Grosk"},
    ["The Barrens"] = {location = "Crossroads", coords = {52.0, 29.8}, innkeeper = "Innkeeper Boorand Plainswind"},
    ["Silverpine Forest"] = {location = "Sepulcher", coords = {45.6, 41.6}, innkeeper = "Innkeeper Bates"},
    ["Hillsbrad Foothills"] = {location = "Tarren Mill", coords = {62.6, 20.6}, innkeeper = "Innkeeper Shay"},

    -- TBC
    ["Hellfire Peninsula"] = {location = "Thrallmar/Honor Hold", coords = {56.6, 62.6}, innkeeper = "Innkeeper Bazil Thredd"},
    ["Zangarmarsh"] = {location = "Cenarion Refuge", coords = {78.5, 63.0}, innkeeper = "Innkeeper Coryth Stoktron"},
    ["Terokkar Forest"] = {location = "Shattrath City", coords = {56.2, 37.8}, innkeeper = "Multiple innkeepers"},
    ["Nagrand"] = {location = "Telaar/Garadar", coords = {54.2, 75.0}, innkeeper = "Innkeeper Coryth Stoktron"},

    -- WotLK
    ["Borean Tundra"] = {location = "Valiance Keep/Warsong Hold", coords = {58.4, 68.4}, innkeeper = "Jennifer Owings/Loggerhead"},
    ["Howling Fjord"] = {location = "Valgarde/Vengeance Landing", coords = {60.4, 16.2}, innkeeper = "Timothy Holland"},
    ["Dragonblight"] = {location = "Wintergarde Keep/Agmar's Hammer", coords = {77.5, 51.8}, innkeeper = "Quartermaster McCarty"},
    ["Grizzly Hills"] = {location = "Amberpine Lodge/Conquest Hold", coords = {64.8, 46.8}, innkeeper = "Jennifer Owings"},

    -- Cataclysm
    ["Mount Hyjal"] = {location = "Nordrassil", coords = {62.8, 23.6}, innkeeper = "Innkeeper Bernice"},
    ["Deepholm"] = {location = "Temple of Earth", coords = {49.6, 51.8}, innkeeper = "Innkeeper Alienne"},
    ["Uldum"] = {location = "Ramkahen", coords = {54.6, 33.0}, innkeeper = "Innkeeper Hathaway"},

    -- Pandaria
    ["The Jade Forest"] = {location = "Dawn's Blossom/Grookin Hill", coords = {45.8, 43.6}, innkeeper = "Innkeeper Liang/Nan Thunderfoot"},
    ["Valley of the Four Winds"] = {location = "Halfhill", coords = {55.1, 50.2}, innkeeper = "Innkeeper Lei Lan"},
    ["Kun-Lai Summit"] = {location = "Binan Village/One Keg", coords = {72.7, 92.3}, innkeeper = "Innkeeper Tao/Weary Jack"},
    ["Townlong Steppes"] = {location = "Longying Outpost", coords = {71.0, 57.8}, innkeeper = "Innkeeper Farley"},

    -- WoD
    ["Frostfire Ridge"] = {location = "Bladespire Fortress", coords = {20.5, 58.3}, innkeeper = "Innkeeper Hazel Lagras"},
    ["Shadowmoon Valley"] = {location = "Lunarfall/Frostwall", coords = {28.4, 29.4}, innkeeper = "Innkeeper Alienne"},
    ["Gorgrond"] = {location = "Beastwatch/Highpass", coords = {46.0, 69.8}, innkeeper = "Innkeeper Kerp"},

    -- Legion
    ["Azsuna"] = {location = "Dalaran", coords = {56.2, 37.8}, innkeeper = "Amisi Azuregaze"},
    ["Val'sharah"] = {location = "Dalaran", coords = {56.2, 37.8}, innkeeper = "Amisi Azuregaze"},
    ["Highmountain"] = {location = "Thunder Totem", coords = {45.6, 44.8}, innkeeper = "Innkeeper Kegleg"},
    ["Stormheim"] = {location = "Valdisdall/Dreadwake's Landing", coords = {60.4, 50.8}, innkeeper = "Inkeeper Orlyn"},
}

-- Check if player's hearthstone is on cooldown
function Travel:GetHearthCooldown()
    local start, duration = GetItemCooldown(6948) -- Hearthstone item ID
    if start > 0 then
        local remaining = duration - (GetTime() - start)
        return remaining > 0 and remaining or 0
    end
    return 0
end

-- Get hearthstone location
function Travel:GetHearthLocation()
    local hearthText = GetBindLocation()
    return hearthText or "Unknown"
end

-- Suggest optimal hearth location based on current zone and quest progression
function Travel:SuggestHearthLocation()
    local zone = GetZoneText()
    local subzone = GetSubZoneText()

    if Travel.optimalHearths[zone] then
        local suggestion = Travel.optimalHearths[zone]
        Travel.data.suggestedHearthLocation = suggestion

        -- Check if player is already at the optimal location
        local currentHearth = self:GetHearthLocation()
        if currentHearth ~= suggestion.location then
            return true, suggestion
        end
    end

    return false, nil
end

-- Display hearth suggestion
function Travel:ShowHearthSuggestion(suggestion)
    if not suggestion then return end

    local message = string.format(
        "|cff00ff00[QuestMaster Pro]|r Suggestion: Set your Hearthstone at |cff00ffff%s|r (%s) for optimal quest efficiency!",
        suggestion.location,
        suggestion.innkeeper
    )

    print(message)

    -- Show on-screen notification
    if QuestMasterPro.UI and QuestMasterPro.UI.ShowNotification then
        QuestMasterPro.UI.ShowNotification("Hearthstone Suggestion", message, 10)
    end
end

-- Track and notify when hearthstone is ready
function Travel:TrackHearthCooldown()
    if not self.config.trackHearthCooldown then return end

    local cooldown = self:GetHearthCooldown()

    if cooldown <= 0 and self.config.notifyOnHearthReady then
        -- Hearthstone is ready
        if self.hearthWasOnCooldown then
            local message = "|cff00ff00[QuestMaster Pro]|r Your Hearthstone is now ready!"
            print(message)

            if QuestMasterPro.UI and QuestMasterPro.UI.ShowNotification then
                QuestMasterPro.UI.ShowNotification("Hearthstone Ready", "Your Hearthstone is ready to use!", 5)
            end

            self.hearthWasOnCooldown = false
        end
    elseif cooldown > 0 then
        self.hearthWasOnCooldown = true
    end
end

-- Flight path optimization data
Travel.flightPathRoutes = {
    -- Key flight path connections and estimated times
    -- Format: [from] = {[to] = travelTime}
    ["Stormwind City"] = {
        ["Goldshire"] = 30,
        ["Sentinel Hill"] = 90,
        ["Lakeshire"] = 120,
        ["Darkshire"] = 150,
    },
    ["Orgrimmar"] = {
        ["Razor Hill"] = 30,
        ["Crossroads"] = 120,
        ["Ratchet"] = 180,
        ["Thunder Bluff"] = 90,
    },
}

-- Suggest optimal flight path
function Travel:SuggestFlightPath(destination)
    if not self.config.autoSuggestFlightPaths then return end

    -- Get current location
    local currentZone = GetZoneText()

    -- Check if there's a faster route via flight paths
    if Travel.flightPathRoutes[currentZone] and Travel.flightPathRoutes[currentZone][destination] then
        local travelTime = Travel.flightPathRoutes[currentZone][destination]
        local minutes = math.floor(travelTime / 60)
        local seconds = travelTime % 60

        local message = string.format(
            "|cff00ff00[QuestMaster Pro]|r Suggestion: Take flight path to %s (~%dm %ds)",
            destination, minutes, seconds
        )

        print(message)
        return true
    end

    return false
end

-- Periodic hearth check
function Travel:PeriodicHearthCheck()
    local currentTime = GetTime()

    if currentTime - self.data.lastHearthCheck >= self.config.hearthReminderInterval then
        self.data.lastHearthCheck = currentTime

        -- Check if we should suggest a new hearth location
        local shouldSuggest, suggestion = self:SuggestHearthLocation()
        if shouldSuggest then
            self:ShowHearthSuggestion(suggestion)
        end

        -- Track hearth cooldown
        self:TrackHearthCooldown()
    end
end

-- Initialize travel optimizer
function Travel:Initialize()
    print("|cff00ff00[QuestMaster Pro]|r Travel Optimizer loaded!")

    -- Create update frame
    local frame = CreateFrame("Frame")
    frame:SetScript("OnUpdate", function()
        Travel:PeriodicHearthCheck()
    end)

    -- Show initial hearth suggestion if appropriate
    C_Timer.After(5, function()
        local shouldSuggest, suggestion = Travel:SuggestHearthLocation()
        if shouldSuggest then
            Travel:ShowHearthSuggestion(suggestion)
        end
    end)
end

-- Slash commands
SLASH_QMPTRAVEL1 = "/qmptravel"
SLASH_QMPTRAVEL2 = "/travel"
SlashCmdList["QMPTRAVEL"] = function(msg)
    if msg == "hearth" then
        local cooldown = Travel:GetHearthCooldown()
        local location = Travel:GetHearthLocation()

        if cooldown > 0 then
            local minutes = math.floor(cooldown / 60)
            local seconds = math.floor(cooldown % 60)
            print(string.format("|cff00ff00[QuestMaster Pro]|r Hearthstone: %s (Ready in %dm %ds)", location, minutes, seconds))
        else
            print(string.format("|cff00ff00[QuestMaster Pro]|r Hearthstone: %s (Ready now!)", location))
        end
    elseif msg == "suggest" then
        local shouldSuggest, suggestion = Travel:SuggestHearthLocation()
        if shouldSuggest then
            Travel:ShowHearthSuggestion(suggestion)
        else
            print("|cff00ff00[QuestMaster Pro]|r Your hearthstone is already optimally placed!")
        end
    else
        print("|cff00ff00[QuestMaster Pro Travel]|r Commands:")
        print("  /travel hearth - Check hearthstone status")
        print("  /travel suggest - Get hearth location suggestion")
    end
end

return Travel
