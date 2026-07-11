# WoW patch support

QuestMaster Pro targets the current Retail client and keeps compatibility metadata for the active Classic clients.

## Current content

- Retail: Midnight 12.0.7, *Revelations* (`120007`)
- Mists of Pandaria Classic 5.5.4 (`50504`)
- Cataclysm Classic 4.4.2 (`40402`)
- Wrath/Titan client 3.4.4 (`30404`)
- Burning Crusade Anniversary 2.5.5 (`20505`)
- Classic Era 1.15.8 (`11508`)

`Core/PatchCompatibility.lua` detects the running client from `GetBuildInfo()` instead of assuming one patch at runtime. `Data/MidnightContent.lua` contains verified Midnight zone metadata. It deliberately omits speculative quest IDs and routes.

When a new patch lands, update the TOC interface metadata and add only content IDs verified in the live client.

