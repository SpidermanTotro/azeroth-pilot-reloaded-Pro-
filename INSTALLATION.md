# 📦 QuestMaster Pro - Installation & Quick Start Guide

## 🎮 Installation

### Method 1: Manual Installation (Recommended for Testing)

1. **Download the Addon**
   - Download the latest release from GitHub
   - Or clone this repository: `git clone https://github.com/SpidermanTotro/QuestMaster-Pro.git`

2. **Install to WoW Directory**
   - Locate your World of Warcraft installation folder
   - Navigate to `Interface\AddOns\`
   - Copy the entire `QuestMaster-Pro/` folder here
   - Rename it to `QuestMasterPro` (remove the trailing dash if present)

3. **Verify Installation**
   - Your folder structure should look like:
     ```
     World of Warcraft\
     └── Interface\
         └── AddOns\
             └── QuestMasterPro\
                 ├── AzerothPilotReloadedPro.toc
                 ├── Main.lua
                 ├── Core\
                 ├── Data\
                 ├── Guides\
                 └── UI\
     ```

4. **Launch WoW**
   - Start World of Warcraft
   - At the character selection screen, click "AddOns"
   - Find "QuestMaster Pro" in the list
   - Make sure it's checked/enabled
   - Click "Okay" and enter the game

### Method 2: CurseForge/Wago (Coming Soon)

Once published, you'll be able to install via:
- CurseForge client
- Wago.io addon manager
- WoWUp client

## 🚀 Quick Start

### First Time Setup

1. **Open the Addon**
   - Type `/qmp` or `/questmaster` in chat
   - Or click the minimap button (if enabled)

2. **Configure Settings**
   - Click the gear icon or type `/qmp settings`
   - Enable/disable features:
     - Auto-accept quests
     - Auto-turn-in quests
     - Show arrow
     - Play sound effects
     - Enable PTR learning (if on PTR/Beta)

3. **Load Your First Guide**
   - Type `/qmp load` to see available guides
   - Example: `/qmp load Elwynn Forest`
   - The guide will appear in your quest tracker

### Basic Commands

```
/qmp                  - Toggle main window
/qmp help             - Show all commands
/qmp settings         - Open settings panel
/qmp load <zone>      - Load a leveling guide
/qmp next             - Skip to next step
/qmp prev             - Go to previous step
/qmp arrow            - Toggle navigation arrow
/qmp reset            - Reset current guide
/qmp class <class>    - Show class guide
/qmp profession <name>- Show profession guide
/qmp gold             - Show gold-making guides
/qmp mythic           - Show M+ guides
```

## 🎯 Features Overview

### Leveling Guides
- **100+ Zones**: All expansions covered
- **Optimized Routes**: Fastest XP paths
- **Quest Ordering**: No backtracking
- **Auto-progression**: Advances automatically

### Navigation
- **Arrow System**: Points to next objective
- **Distance Tracking**: Real-time distance updates
- **Waypoints**: Multiple waypoint support
- **Mini-map Integration**: See markers on mini-map

### Class Guides
- **All 13 Classes**: Death Knight to Warrior
- **Spec-Specific**: Guides for each specialization
- **Rotation Tips**: Optimal spell usage
- **Talent Builds**: Recommended talents

### Profession Guides
- **All 15 Professions**: Crafting & gathering
- **1-800 Leveling**: Complete paths
- **Cost Estimates**: Gold requirements
- **Money-Making**: Profitable crafting

### Mythic+ System
- **Affix Strategies**: All affixes explained
- **Dungeon Routes**: Optimal paths
- **Boss Mechanics**: Key mechanics to know
- **Gear Rewards**: Know what drops where

### Advanced Features
- **PTR Integration**: Auto-learns new content
- **Group Sync**: Coordinate with party
- **Achievement Tracking**: Loremaster, reps, etc.
- **Gold-Making**: 10k-50k/hour methods

## 📖 Usage Examples

### Example 1: Start Leveling in Elwynn Forest
```
/qmp load Elwynn Forest
```
The guide loads, showing step 1. Follow the arrow to the first quest giver.

### Example 2: Check Your Class Guide (Mage)
```
/qmp class Mage
```
Opens class guide with spec recommendations, rotation tips, and stat priorities.

### Example 3: Level Alchemy
```
/qmp profession Alchemy
```
Shows complete 1-800 Alchemy guide with materials needed.

### Example 4: Prepare for Mythic+
```
/qmp mythic
```
Opens M+ guide system with current affix rotation and strategies.

## ⚙️ Settings Explained

### Quest Automation
- **Auto-Accept**: Automatically accepts recommended quests
- **Auto-Turn-In**: Automatically completes quests (careful with choices!)
- **Quest Filtering**: Only shows relevant quests

### Visual Settings
- **Show Arrow**: Display navigation arrow
- **Arrow Size**: Adjust arrow size (50%-200%)
- **Arrow Transparency**: Adjust opacity
- **Modern UI**: Enable glassmorphism design

### Audio Settings
- **Sound Effects**: Play sounds on step completion
- **Voice Navigation**: (Coming Q3 2026)

### Advanced Settings
- **PTR Learning**: Enable on PTR/Beta to capture new quests
- **Group Sync**: Share progress with party
- **Debug Mode**: Show detailed logging

## 🐛 Troubleshooting

### Addon Not Showing Up
- Verify folder is named `QuestMasterPro` (not with extra characters)
- Check it's in correct location: `Interface\AddOns\QuestMasterPro\`
- Make sure you clicked "Enable" in the AddOns menu
- Try `/reload` in-game

### Arrow Not Appearing
- Check `/qmp settings` - ensure "Show Arrow" is enabled
- Type `/qmp arrow` to toggle
- Make sure a guide is loaded first

### Guide Not Loading
- Verify you spelled the zone name correctly
- Type `/qmp load` to see available guides
- Some zones may not have guides yet (see roadmap)

### Quest Auto-Accept Not Working
- Check settings - auto-accept must be enabled
- Some quests can't be auto-accepted (daily quests, special quests)
- Must be in range of quest giver

### Performance Issues
- Disable "Modern UI" for better performance
- Reduce arrow update frequency in settings
- Close other resource-heavy addons

## 🆘 Getting Help

### In-Game Help
```
/qmp help            - Show command list
/qmp version         - Show version info
/qmp status          - Show addon status
```

### Online Resources
- **GitHub Issues**: https://github.com/SpidermanTotro/QuestMaster-Pro/issues
- **Documentation**: See README.md
- **Contributing**: See CONTRIBUTING.md

## 🎊 You're Ready!

QuestMaster Pro is now installed and ready to guide you through Azeroth!

**Pro Tips:**
- Start with a low-level zone guide to learn the system
- Customize settings to your preference
- Try the class guide for your main
- Check out the gold-making guides to fund your adventures
- Join the community to request new features!

**Enjoy your journey through Azeroth!** 🗺️✨

---

**QuestMaster Pro** - Free, Fast, Future-Ready! 🚀
