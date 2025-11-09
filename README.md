# Azeroth Pilot Reloaded Pro

**The NEXT GENERATION leveling addon for World of Warcraft - Built for 2025 and beyond!**

[![Discord](https://img.shields.io/badge/Discord-Join%20Us-7289da.svg)](https://discord.gg/placeholder)
[![GitHub](https://img.shields.io/badge/GitHub-Contribute-181717.svg)](https://github.com/SpidermanTotro/azeroth-pilot-reloaded-Pro-)
[![License](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](LICENSE)

## 🚀 Why Azeroth Pilot Reloaded Pro?

The leveling addon landscape is **falling behind**. While competitors struggle to keep pace with new content, **Azeroth Pilot Reloaded Pro** leads the way with:

### 📊 The Competition Is Struggling:

- **Azeroth Auto Pilot**: DEPRECATED - No longer maintained
- **Azeroth Pilot Reloaded**: Active but has 15+ open issues, limited updates
- **Zygor Guides**: Pandaria Classic released July 21, 2025 - PAID subscription required ($10/month)
- **Rested XP**: Frequent updates but limited free features
- **Dugi Guides**: Updates lag behind patches, API changes cause downtime

### ✨ Our Competitive Advantages:

#### 🔥 **Faster Updates**
- **FREE and Open Source** - No subscriptions, ever!
- **Community-Driven Development** - Updates pushed as content releases
- **Modern Codebase** - Built from the ground up for 2025+
- **Instant Pandaria Classic Support** - Day-1 coverage for new content

#### 💪 **Superior Features**
- ✅ Advanced waypoint arrow with real-time distance tracking
- ✅ Smart quest automation (optional auto-accept/turn-in)
- ✅ Beautiful, customizable UI that's movable and scalable
- ✅ Multi-expansion support (Vanilla → The War Within)
- ✅ Group questing with party sync
- ✅ Built-in coordinate display
- ✅ Zero bloat - Efficient and lightweight

#### 🎯 **Complete Coverage**
- Full leveling guides from 1-80+
- **Pandaria Classic guides** (FRESH for 2025!)
- Legion, BfA, Shadowlands, Dragonflight routes
- The War Within expansion support
- Custom route creator

---

## 📖 Features

### Core Features

**Intelligent Quest Tracking**
- Automatic quest objective tracking with progress counters
- Smart quest ordering for optimal efficiency
- Quest chain detection and management
- Detailed notes for tricky objectives

**Advanced Navigation**
- Built-in waypoint arrow (no TomTom required!)
- Real-time distance calculation in yards
- Color-coded proximity indicators
- Map integration with visual pins

**Automation (Optional)**
- Auto-accept quests on your route
- Auto-turn in completed quests
- Auto-select gossip options
- Auto-skip cutscenes (when applicable)

**Modern UI**
- Fully movable interface elements
- Scalable frames and text
- Clean, unobtrusive design
- Integrated with default UI

**Social Features**
- Party synchronization
- See party members' current steps
- Coordinate group leveling

---

## 🎮 Getting Started

### Installation

1. Download the latest release
2. Extract to `World of Warcraft/_retail_/Interface/AddOns/`
3. Restart WoW or reload UI (`/reload`)
4. Type `/ap` to get started!

### Quick Start

```
/ap start          - Auto-detect and start appropriate guide
/ap guides         - List all available guides
/ap show           - Show the guide window
/ap config         - Open settings panel
```

### Full Command List

```
/ap help           - Show all commands
/ap start [guide]  - Start a specific guide
/ap stop           - Stop current guide
/ap next           - Advance to next step
/ap prev           - Go back one step
/ap toggle         - Toggle guide window
/ap reset          - Reset progress
/ap version        - Show version info
/ap debug          - Toggle debug mode
```

---

## 📚 Available Guides

### Retail (Live)
- **Vanilla Zones** (1-60): All Alliance and Horde starting zones
- **The Burning Crusade** (58-70): Outland routes
- **Wrath of the Lich King** (68-80): Northrend routes
- **Cataclysm** (80-85): Revamped world routes
- **Mists of Pandaria** (80-90): **FRESH 2025 COVERAGE!**
  - Complete Jade Forest guides (Alliance & Horde)
  - Valley of the Four Winds
  - All Pandaria zones
- **Warlords of Draenor** (90-100): Draenor routes
- **Legion** (98-110): Broken Isles routes
- **Battle for Azeroth** (110-120): Kul Tiras & Zandalar
- **Shadowlands** (120-130): Covenant campaigns
- **Dragonflight** (130-140): Dragon Isles
- **The War Within** (140-150): Latest expansion

---

## ⚙️ Configuration

Access settings via `/ap config` or `ESC → Interface → AddOns → Azeroth Pilot Pro`

### Available Options:
- Enable/Disable addon
- Show/Hide navigation arrow
- Auto-accept quests toggle
- Auto-turn in quests toggle
- Sound effects toggle
- Arrow scale adjustment
- UI customization

---

## 🛠️ For Developers

### Contributing

We welcome contributions! This addon is built to be:
- **Modular**: Easy to add new guides
- **Extensible**: Plugin architecture for custom features
- **Well-documented**: Clear code with comments
- **Modern**: Using latest WoW API practices

### Adding Custom Guides

See `Data/Routes.lua` for examples. Guide structure:

```lua
{
    id = "zone_level_range",
    name = "Zone Name",
    faction = "Alliance" or "Horde" or "Neutral",
    minLevel = 10,
    maxLevel = 20,
    steps = {
        {
            title = "Step Title",
            description = "What to do",
            action = "accept|turnin|goto|kill",
            questID = 12345,
            waypoint = { x = 0.5, y = 0.5 }
        }
    }
}
```

---

## 📜 Comparison with Competitors

| Feature | APR Pro | AAP | Zygor | RestedXP | Dugi |
|---------|---------|-----|-------|----------|------|
| Cost | **FREE** | Deprecated | $10/mo | Free/Paid | Paid |
| Pandaria Classic | ✅ Day 1 | ❌ | ✅ Delayed | ✅ Delayed | ✅ Delayed |
| Open Source | ✅ | ❌ | ❌ | ❌ | ❌ |
| Active Development | ✅ | ❌ | ✅ | ✅ | ✅ |
| Auto Quest Tracking | ✅ | ✅ | ✅ | ✅ | ✅ |
| Built-in Arrow | ✅ | ✅ | ✅ | ❌ | ✅ |
| Group Sync | ✅ | ❌ | ❌ | ❌ | ❌ |
| Update Speed | **Fast** | N/A | Slow | Medium | Slow |
| Community Driven | ✅ | ❌ | ❌ | ❌ | ❌ |

---

## 🤝 Credits & Acknowledgments

**Azeroth Pilot Reloaded Pro** builds upon the legacy of great leveling addons:

- **Azeroth Auto Pilot Team** - Original vision and innovation
- **Azeroth Pilot Reloaded Team** - Continuation efforts (Neogeekmo, Kamian, Pahonix, and all contributors)
- **Community Contributors** - Route designers, testers, and feedback providers

This project aims to push the genre forward with modern development practices, faster updates, and a commitment to remaining free and open source.

---

## 📄 License

GPL-3.0 License - See LICENSE file for details

---

## 🔗 Links

- **GitHub**: https://github.com/SpidermanTotro/azeroth-pilot-reloaded-Pro-
- **Issues**: https://github.com/SpidermanTotro/azeroth-pilot-reloaded-Pro-/issues
- **Discussions**: https://github.com/SpidermanTotro/azeroth-pilot-reloaded-Pro-/discussions

---

## 📢 Support & Community

Found a bug? Have a suggestion? Want to contribute?

- 🐛 [Report Issues](https://github.com/SpidermanTotro/azeroth-pilot-reloaded-Pro-/issues)
- 💡 [Request Features](https://github.com/SpidermanTotro/azeroth-pilot-reloaded-Pro-/issues/new)
- 🤝 [Contribute](https://github.com/SpidermanTotro/azeroth-pilot-reloaded-Pro-/pulls)

---

**Azeroth Pilot Reloaded Pro** - The future of WoW leveling guides is here! 🚀