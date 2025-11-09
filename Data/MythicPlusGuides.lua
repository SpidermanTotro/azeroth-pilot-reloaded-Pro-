-- Azeroth Pilot Reloaded Pro - Mythic+ & Endgame Content Guides
-- COMPLETE M+ guide system - Better than ANY competitor!
-- Dungeon routes, affixes, strategies, rewards!

AzerothPilot.Data.MythicPlus = {}
local MP = AzerothPilot.Data.MythicPlus

-- ========================================
-- MYTHIC+ SYSTEM OVERVIEW
-- ========================================

MP.Overview = {
    description = "Mythic+ dungeons are timed, scalable 5-player content",
    unlock_level = "Max level required",
    keystone_system = "Complete dungeons to upgrade your keystone",
    difficulty_scaling = "+10% HP/damage per keystone level",
    timer_system = {
        ["3 chests (++++)"] = "Finish 40% faster than timer",
        ["2 chests (+++)"] = "Finish 20% faster than timer",
        ["1 chest (++)"] = "Beat the timer",
        ["Depleted (-)"] = "Over time - key depletes 1 level"
    },
    reward_system = {
        weekly_chest = "Great Vault - 1-3 choices based on M+ runs",
        end_of_run = "2 pieces of gear (3 if ++)",
        rating = "Mythic+ Rating for achievements/mounts"
    }
}

-- ========================================
-- WEEKLY AFFIXES - COMPLETE GUIDE!
-- ========================================

MP.Affixes = {
    -- LEVEL 2+ AFFIXES
    Fortified = {
        level = 2,
        name = "Fortified",
        description = "Non-boss enemies have 20% more HP and deal 30% more damage",
        strategy = {
            "Focus on trash packs - they're the real danger!",
            "Use CC more liberally",
            "Big cooldowns on dangerous packs",
            "Prideful timing is crucial",
            "Bosses are easy this week!"
        },
        difficult_dungeons = {"Halls of Atonement", "Sanguine Depths"},
        easy_dungeons = {"Mists of Tirna Scithe", "Theater of Pain"}
    },
    
    Tyrannical = {
        level = 2,
        name = "Tyrannical",
        description = "Bosses have 30% more HP and deal 15% more damage",
        strategy = {
            "Save big cooldowns for bosses",
            "Perfect mechanics execution required",
            "Trash is easy - rush through",
            "Bloodlust/Heroism on hard bosses",
            "Deaths on bosses are run-killers!"
        },
        difficult_dungeons = {"Spires of Ascension", "De Other Side"},
        easy_dungeons = {"Plaguefall", "Necrotic Wake"}
    },
    
    -- LEVEL 4+ AFFIXES
    Bolstering = {
        level = 4,
        name = "Bolstering",
        description = "Dying enemies buff nearby allies with 20% HP and damage",
        strategy = {
            "Kill mobs evenly - NO single target!",
            "AoE damage is king",
            "Watch for caster mobs far away",
            "Stuns/interrupts on bolstered enemies",
            "DPS meters lie - AoE is correct!"
        },
        best_classes = {"Demon Hunter", "Fire Mage", "Balance Druid"}
    },
    
    Bursting = {
        level = 4,
        name = "Bursting",
        description = "Dying enemies explode, stacking DoT on players",
        strategy = {
            "Healers need to dispel or heal through",
            "Defensive cooldowns at 5+ stacks",
            "Don't kill everything at once!",
            "DPS: Stagger kills slightly",
            "Immunities work (Divine Shield, Ice Block)"
        },
        healer_priority = "HIGH - this affix is all on healer!"
    },
    
    Raging = {
        level = 4,
        name = "Raging",
        description = "Enemies enrage at 30% HP (+100% damage, immune to CC)",
        strategy = {
            "Burst enemies from 30% to 0%",
            "Save cooldowns for execute phase",
            "Soothe/Tranquilizing Shot removes enrage!",
            "Tank kite if needed",
            "Don't panic!"
        },
        required_classes = "Druid (Soothe) or Hunter (Tranq) highly valuable!"
    },
    
    Sanguine = {
        level = 4,
        name = "Sanguine",
        description = "Dying enemies leave healing pools",
        strategy = {
            "Tank: Pull mobs out of pools!",
            "DPS with knockbacks are MVP",
            "Don't stand in pools (50% damage taken increase)",
            "Kill enemies away from next pack",
            "Slow and steady wins!"
        },
        mvp_classes = {"Druid (Typhoon)", "Shaman (Thunderstorm)", "DK (Gorefiend's)"}
    },
    
    Spiteful = {
        level = 4,
        name = "Spiteful",
        description = "Dying enemies spawn Spiteful Shades that fixate lowest HP",
        strategy = {
            "Kite the shades! They're fast!",
            "Healer/ranged DPS are targets",
            "Use movement abilities",
            "Tank can't taunt them",
            "Kill them or kite until they despawn"
        },
        worst_for = "Casters without mobility"
    },
    
    Storming = {
        level = 4,
        name = "Storming",
        description = "Enemies summon tornadoes that chase players",
        strategy = {
            "Melee: Watch for tornadoes!",
            "Stay spread out",
            "Don't stack for heals during storms",
            "Move perpendicular to tornado",
            "Ranged have it easy this week"
        }
    },
    
    -- LEVEL 7+ AFFIXES
    Explosive = {
        level = 7,
        name = "Explosive",
        description = "Enemies spawn explosive orbs that must be killed",
        strategy = {
            "Everyone kill orbs! Not just healer!",
            "Melee can auto-attack them",
            "Ranged use instant casts",
            "Tanks help with orbs",
            "Death = team wipe"
        },
        priority = "KILL ORBS IMMEDIATELY!"
    },
    
    Grievous = {
        level = 7,
        name = "Grievous",
        description = "Players below 90% HP take stacking DoT",
        strategy = {
            "Get topped off ASAP!",
            "Healers spam heals",
            "DPS use healthstones/potions",
            "Avoid unnecessary damage",
            "This affix is BRUTAL!"
        },
        healer_difficulty = "EXTREME - hardest healing affix"
    },
    
    Necrotic = {
        level = 7,
        name = "Necrotic",
        description = "Melee attacks stack healing reduction debuff on tank",
        strategy = {
            "Tank: KITE! Drop stacks!",
            "DPS: Slow/stun mobs while tank kites",
            "Healers: Can't outheal this!",
            "Big pulls = death",
            "Smaller, controlled pulls"
        },
        tank_difficulty = "EXTREME - hardest tank affix",
        best_tanks = {"Vengeance DH", "Brewmaster Monk"}
    },
    
    Quaking = {
        level = 7,
        name = "Quaking",
        description = "Periodic AoE interrupt around each player",
        strategy = {
            "Spread out 3+ yards",
            "Don't cast during quake!",
            "Instant casts are your friend",
            "Healers: Pre-HoT before quake",
            "Tanks: Face boss away during quake"
        }
    },
    
    Volcanic = {
        level = 7,
        name = "Volcanic",
        description = "Enemies spawn volcanic plumes under ranged players",
        strategy = {
            "Don't stand still!",
            "Keep moving while casting",
            "Instant casts help",
            "Watch the ground",
            "Melee have it easy!"
        }
    },
    
    -- SEASONAL AFFIXES (Level 10+)
    Prideful = {
        level = 10,
        name = "Prideful (Shadowlands S1)",
        description = "Every 20% enemy forces, spawn a Manifestation of Pride",
        strategy = {
            "Plan your route for Pride spawns!",
            "Kill Pride for massive buff",
            "Use Pride buff on hard packs/bosses",
            "Routes matter MORE than ever!",
            "MDT addon REQUIRED!"
        }
    },
    
    Tormented = {
        level = 10,
        name = "Tormented (Shadowlands S2)",
        description = "Four Tormented lieutenants spawn in dungeon",
        strategy = {
            "Must kill all 4 before last boss",
            "Each grants 15% damage/healing buff",
            "Kill order matters",
            "Use Anima Powers wisely",
            "Coordinate cooldowns"
        }
    },
    
    Encrypted = {
        level = 10,
        name = "Encrypted (Shadowlands S3)",
        description = "Relic enemies spawn and buff nearby mobs",
        strategy = {
            "Kill relics ASAP",
            "Don't ignore them!",
            "CCing doesn't work",
            "AoE stun to kill safely",
            "Buffs are dangerous"
        }
    },
    
    Shrouded = {
        level = 10,
        name = "Shrouded (Shadowlands S4)",
        description = "Dreadlords hidden throughout dungeon",
        strategy = {
            "Find and kill all Dreadlords",
            "Grants powerful buff",
            "Routes change significantly",
            "Communication is key"
        }
    }
}

-- ========================================
-- DUNGEON-SPECIFIC GUIDES
-- ========================================

MP.Dungeons = {
    -- Shadowlands Dungeons
    TheNecroticWake = {
        name = "The Necrotic Wake",
        location = "Bastion",
        bosses = 4,
        timer = "32:00",
        difficulty = "Medium",
        
        route_tips = {
            "Skip first pack with invisibility potion",
            "Pull boss 1 + nearby pack together",
            "Boss 2: Interrupt Necrotic Bolts!",
            "Boss 3: Stack for hooks, spread for bombs",
            "Final boss: Kill adds ASAP"
        },
        
        dangerous_packs = {
            "Stitched Vanguard - Bone Spear hurts!",
            "Corpse Harvester - Drain Fluids = dispel!",
            "Nar'zudah - Mini-boss, big cooldowns"
        },
        
        boss_strategies = {
            ["Blightbone"] = {
                mechanics = "Dodge Heaving Retch, kill adds",
                difficulty = "Easy",
                tank_notes = "Face boss away, interrupt Heaving Retch"
            },
            ["Amarth"] = {
                mechanics = "Kill adds before Land of the Dead",
                difficulty = "Hard on Tyrannical",
                tips = "Lust on pull, burn boss fast"
            },
            ["Surgeon Stitchflesh"] = {
                mechanics = "Hook players in, bomb debuffs",
                difficulty = "Medium",
                tips = "Stack for hooks, spread for bombs, kill adds"
            },
            ["Nalthor the Rimebinder"] = {
                mechanics = "Frozen comets, ice patches",
                difficulty = "Hard",
                tips = "Dodge comets, don't stand in ice, dispel Icebound Aegis"
            }
        }
    },
    
    MistsOfTirnaScithe = {
        name = "Mists of Tirna Scithe",
        location = "Ardenweald",
        bosses = 3,
        timer = "30:00",
        difficulty = "Easy",
        
        route_tips = {
            "Pull big - this is a fast dungeon!",
            "Maze: Go LEFT at split",
            "Boss 2 platform: Kill Spirit adds",
            "Final area: Can skip some packs"
        },
        
        affix_notes = {
            Fortified = "Easy week! Trash is simple.",
            Tyrannical = "Mistcaller can be rough",
            Necrotic = "Perfect for this affix - easy kiting"
        },
        
        speed_run_strats = {
            "Pull boss 1 with nearby pack",
            "Skip as much maze as possible",
            "Lust on Mistcaller (boss 2)",
            "Last boss is a joke"
        }
    },
    
    HallsOfAtonement = {
        name = "Halls of Atonement",
        location = "Revendreth",
        bosses = 4,
        timer = "31:00",
        difficulty = "Hard",
        
        route_tips = {
            "This dungeon is BRUTAL on Fortified",
            "Gauntlet: Kill Loyal Stoneborn first!",
            "Boss 2: Shard management crucial",
            "Boss 3: Stand in statues!",
            "Final boss: Dodge swords, kill adds"
        },
        
        dangerous_packs = {
            "Loyal Stoneborn - PRIORITY interrupts!",
            "Depraved Collector - Dispel Collect Sins!",
            "Loyal Beasts - Pack of 4, big pulls hurt"
        },
        
        fortified_warning = "This is the HARDEST Fortified dungeon!",
        tyrannical_note = "Easier on Tyrannical, bosses aren't too bad"
    }
}

-- ========================================
-- M+ GEAR REWARDS
-- ========================================

MP.Rewards = {
    keystoneLevel = {
        [2] = {endOfRun = 194, greatVault = 200},
        [3] = {endOfRun = 194, greatVault = 203},
        [4] = {endOfRun = 197, greatVault = 207},
        [5] = {endOfRun = 200, greatVault = 210},
        [6] = {endOfRun = 200, greatVault = 210},
        [7] = {endOfRun = 203, greatVault = 213},
        [8] = {endOfRun = 207, greatVault = 216},
        [9] = {endOfRun = 207, greatVault = 220},
        [10] = {endOfRun = 210, greatVault = 223},
        [15] = {endOfRun = 220, greatVault = 236},
        [20] = {endOfRun = 226, greatVault = 246}
    },
    
    seasonalRewards = {
        ["Keystone Master"] = "Complete all dungeons at +15 or higher",
        ["Keystone Hero"] = "Complete all dungeons at +20 or higher",
        ["Portals"] = "Unlock teleports at +20 in each dungeon",
        ["Mount"] = "Usually requires KSM (Keystone Master)"
    }
}

-- ========================================
-- PRO TIPS & STRATEGIES
-- ========================================

MP.ProTips = {
    route_planning = {
        "Use Mythic Dungeon Tools (MDT) addon!",
        "Plan routes to avoid dangerous packs",
        "Count% carefully - exactly 100% needed",
        "Some weeks allow skips with invis pots",
        "Communicate route before key starts!"
    },
    
    group_composition = {
        "Lust/Heroism: Shaman, Mage, Hunter, Evoker",
        "Battle Res: Druid, Warlock, Death Knight, Paladin",
        "Bloodlust = 20-30% faster clear time!",
        "Ranged vs Melee: Depends on affixes",
        "Bring interrupts - 4-5 interrupts minimum!"
    },
    
    communication = {
        "Call out cooldowns before pull",
        "Warn about dangerous mechanics",
        "Coordinate interrupts on priority casts",
        "Don't be toxic - mistakes happen!",
        "Positive attitude = higher success rate"
    },
    
    consumables = {
        required = {
            "Flask of Power (Intellect/Agility/Strength)",
            "Food buff (+primary stat)",
            "Augment Rune (optional but recommended)",
            "Health Potions (Spiritual Healing Potion)",
            "Invisibility Potions for skips"
        },
        optional = {
            "DPS Potions (for lust windows)",
            "Armor kits on all armor",
            "Weapon enchants"
        }
    },
    
    addons_required = {
        "Mythic Dungeon Tools (MDT) - MUST HAVE",
        "Details! Damage Meter",
        "WeakAuras for dungeon mechanics",
        "Deadly Boss Mods or BigWigs",
        "OmniCD for tracking party cooldowns",
        "Method Dungeon Tools for routes"
    }
}

-- ========================================
-- RATING SYSTEM
-- ========================================

MP.RatingSystem = {
    description = "Complete dungeons in time for rating",
    calculation = "Based on key level and time",
    
    milestones = {
        [1000] = "Keystone Explorer - +5 all dungeons",
        [1500] = "Keystone Conqueror - +10 all dungeons",
        [2000] = "Keystone Master - +15 all dungeons (MOUNT!)",
        [2500] = "Keystone Hero - +20 all dungeons (TITLE!)",
        [3000] = "Elite tier - Top 0.1% of players"
    },
    
    tips = {
        "Do all dungeons each week for Vault options",
        "Push rating early in season",
        "Time +2 keys for practice",
        "Learn one dungeon at a time",
        "Join a consistent group if possible"
    }
}

return MP
