-- Azeroth Pilot Reloaded Pro - COMPLETE Class & Gear Guide
-- ALL 13 classes! ALL specs! Gear recommendations! Talents! Rotations!
-- MORE detailed than Zygor - 100% FREE!

AzerothPilot.Data.Classes = {}
local Classes = AzerothPilot.Data.Classes

-- ========================================
-- ALL 13 CLASSES - COMPLETE DATA!
-- ========================================

Classes.AllClasses = {
    DeathKnight = {
        id = 1, name = "Death Knight", icon = 135771,
        armor = "Plate", resource = "Runic Power", roles = {"Tank", "Melee DPS"},
        available_races = {
            Alliance = {"Human", "Dwarf", "Night Elf", "Gnome", "Draenei", "Worgen", "Pandaren"},
            Horde = {"Orc", "Undead", "Tauren", "Troll", "Blood Elf", "Goblin", "Pandaren"}
        },
        specs = {
            Blood = {
                name = "Blood", role = "Tank", difficulty = "Medium",
                description = "Dark protector who wields plague and blood magic",
                bestStats = {"Stamina", "Versatility", "Haste"},
                talents_priority = "Focus on survivability and threat generation",
                rotation = {
                    "1. Marrowrend (maintain 5 stacks Bone Shield)",
                    "2. Death Strike (on high damage intake)",
                    "3. Heart Strike (dump Runic Power)",
                    "4. Blood Boil (AoE damage + threat)",
                    "5. Death and Decay (AoE situations)"
                }
            },
            Frost = {
                name = "Frost", role = "Melee DPS", difficulty = "Easy",
                description = "Dual-wielding master of frozen fury",
                bestStats = {"Strength", "Mastery", "Critical Strike"},
                rotation = {
                    "1. Obliterate (generate Runes)",
                    "2. Frost Strike (dump Runic Power)",
                    "3. Howling Blast (Rime proc)",
                    "4. Breath of Sindragosa (maintain if talented)"
                }
            },
            Unholy = {
                name = "Unholy", role = "Melee DPS", difficulty = "Hard",
                description = "Master of death and decay with a trusty ghoul",
                bestStats = {"Strength", "Haste", "Mastery"},
                rotation = {
                    "1. Outbreak (apply diseases)",
                    "2. Festering Strike (build Festering Wounds)",
                    "3. Scourge Strike (pop wounds)",
                    "4. Death Coil (dump Runic Power)",
                    "5. Summon Gargoyle (cooldown)"
                }
            }
        },
        leveling_guide = {
            best_spec = "Frost",
            why = "Simple rotation, great AoE, self-healing",
            heirlooms = {"Worn Stoneskin Gargoyle Cape", "Bloodied Arcanite Reaper"},
            tips = {
                "Start at level 55/58 (depending on expansion)",
                "Frost is easiest - dual-wield for fast leveling",
                "Use Death Strike for self-healing",
                "Army of the Dead for tough pulls",
                "Control Undead for permanent pet (Unholy)"
            }
        },
        endgame_gear = {
            tank = {
                weapons = "2H Weapon (Strength + Stamina)",
                armor_priority = "Stamina > Versatility > Haste > Mastery",
                trinkets = "Tank trinkets with on-use defensive"
            },
            dps = {
                weapons = "Dual-Wield 1H (Frost) or 2H (Unholy/Frost)",
                armor_priority = "Strength > Crit/Mastery/Haste (depends on spec)",
                trinkets = "Proc trinkets or stat sticks"
            }
        }
    },
    
    DemonHunter = {
        id = 2, name = "Demon Hunter", icon = 1260827,
        armor = "Leather", resource = "Fury", roles = {"Tank", "Melee DPS"},
        available_races = {
            Alliance = {"Night Elf"},
            Horde = {"Blood Elf"}
        },
        specs = {
            Havoc = {
                name = "Havoc", role = "Melee DPS", difficulty = "Easy",
                description = "Agile melee DPS with insane mobility",
                bestStats = {"Agility", "Critical Strike", "Versatility"},
                rotation = {
                    "1. Eye Beam (on cooldown)",
                    "2. Blade Dance (on cooldown)",
                    "3. Immolation Aura",
                    "4. Demon's Bite (generate Fury)",
                    "5. Chaos Strike (dump Fury)"
                }
            },
            Vengeance = {
                name = "Vengeance", role = "Tank", difficulty = "Medium",
                description = "Incredibly mobile tank with self-healing",
                bestStats = {"Stamina", "Haste", "Versatility"}
            }
        },
        leveling_guide = {
            best_spec = "Havoc",
            why = "FASTEST leveling class! Insane AoE and mobility!",
            tips = {
                "Starts at level 98 (Legion)",
                "Double jump + glide everywhere",
                "Eye Beam everything",
                "Metamorphosis for tough packs",
                "Can solo elite quests easily"
            }
        }
    },
    
    Druid = {
        id = 3, name = "Druid", icon = 625999,
        armor = "Leather", resource = "Varies by form", roles = {"Tank", "Healer", "Melee DPS", "Ranged DPS"},
        available_races = {
            Alliance = {"Night Elf", "Worgen", "Kul Tiran"},
            Horde = {"Tauren", "Troll", "Zandalari Troll"}
        },
        specs = {
            Balance = {
                name = "Balance", role = "Ranged DPS", difficulty = "Medium",
                description = "Moonkin - Master of nature's wrath",
                bestStats = {"Intellect", "Haste", "Critical Strike"},
                note = "Great for leveling! Strong AoE!"
            },
            Feral = {
                name = "Feral", role = "Melee DPS", difficulty = "Hard",
                description = "Cat form - Bleeds and stealth",
                bestStats = {"Agility", "Critical Strike", "Mastery"},
                note = "Complex rotation but VERY strong!"
            },
            Guardian = {
                name = "Guardian", role = "Tank", difficulty = "Easy",
                description = "Bear form - Thick fur, thicc health pool",
                bestStats = {"Stamina", "Versatility", "Mastery"}
            },
            Restoration = {
                name = "Restoration", role = "Healer", difficulty = "Medium",
                description = "HoT-based healing with great utility",
                bestStats = {"Intellect", "Haste", "Mastery"}
            }
        },
        leveling_guide = {
            best_spec = "Balance or Feral",
            why = "Balance = easy AoE, Feral = fast single target",
            unique_benefits = {
                "INSTANT FLIGHT FORM at max level!",
                "Travel Form at level 10 (30% faster)",
                "Stealth (Feral) for quest objectives",
                "Self-healing (all specs)",
                "Can gather herbs in flight form!"
            },
            tips = {
                "Use Balance for quest hubs with many enemies",
                "Use Feral for single-target quests",
                "Bear form for tough elites",
                "Regrowth + Rejuvenation for healing",
                "Dash for extra speed"
            }
        }
    },
    
    Evoker = {
        id = 4, name = "Evoker", icon = 4574311,
        armor = "Mail", resource = "Essence", roles = {"Healer", "Ranged DPS"},
        available_races = {
            Alliance = {"Dracthyr"},
            Horde = {"Dracthyr"}
        },
        specs = {
            Devastation = {
                name = "Devastation", role = "Ranged DPS", difficulty = "Medium",
                description = "Red/Blue dragonflight magic - empowered spells!",
                bestStats = {"Intellect", "Mastery", "Critical Strike"}
            },
            Preservation = {
                name = "Preservation", role = "Healer", difficulty = "Easy",
                description = "Green/Bronze healing - preventative + HoTs",
                bestStats = {"Intellect", "Mastery", "Versatility"}
            },
            Augmentation = {
                name = "Augmentation", role = "Support DPS", difficulty = "Hard",
                description = "UNIQUE! Buffs allies' damage!",
                bestStats = {"Intellect", "Mastery", "Versatility"},
                note = "Only support DPS in WoW!"
            }
        },
        leveling_guide = {
            best_spec = "Devastation",
            why = "Strong burst, good AoE, mobile",
            tips = {
                "Starts at level 58 (Dragonflight)",
                "Use empowered spells at Rank 1 while leveling",
                "Soar ability = flying without mount!",
                "Self-healing with Emerald Blossom",
                "Interrupt with Quell"
            }
        }
    },
    
    Hunter = {
        id = 5, name = "Hunter", icon = 626000,
        armor = "Mail", resource = "Focus", roles = {"Melee DPS", "Ranged DPS"},
        available_races = {
            Alliance = {"All except Draenei"},
            Horde = {"All"}
        },
        specs = {
            BeastMastery = {
                name = "Beast Mastery", role = "Ranged DPS", difficulty = "Easy",
                description = "Pet does most damage - BEST for leveling!",
                bestStats = {"Agility", "Mastery", "Haste"},
                note = "ONLY spec that can move while casting!"
            },
            Marksmanship = {
                name = "Marksmanship", role = "Ranged DPS", difficulty = "Medium",
                description = "Sniper spec - big crits, no pet",
                bestStats = {"Agility", "Critical Strike", "Mastery"}
            },
            Survival = {
                name = "Survival", role = "Melee DPS", difficulty = "Hard",
                description = "Melee hunter with traps and bombs",
                bestStats = {"Agility", "Versatility", "Haste"}
            }
        },
        leveling_guide = {
            best_spec = "Beast Mastery",
            why = "EASIEST leveling in game! Pet tanks, you DPS!",
            pet_recommendations = {
                tank = "Tenacity pet (Bear, Turtle) - takes less damage",
                dps = "Ferocity pet (Cat, Wolf) - more damage",
                utility = "Cunning pet (Fox, Monkey) - movement"
            },
            tips = {
                "Tame a Tenacity pet for leveling",
                "Mend Pet to heal your pet",
                "Misdirection = pull to pet",
                "Feign Death to drop aggro",
                "Can solo most elite quests!",
                "Tame rare pets for collection!"
            }
        }
    },
    
    Mage = {
        id = 6, name = "Mage", icon = 626001,
        armor = "Cloth", resource = "Mana", roles = {"Ranged DPS"},
        available_races = {
            Alliance = {"All except Worgen"},
            Horde = {"All except Tauren"}
        },
        specs = {
            Arcane = {
                name = "Arcane", role = "Ranged DPS", difficulty = "Easy",
                description = "Mana management - conserve then burn!",
                bestStats = {"Intellect", "Mastery", "Versatility"}
            },
            Fire = {
                name = "Fire", role = "Ranged DPS", difficulty = "Medium",
                description = "Pyroblast! Critical strike heaven!",
                bestStats = {"Intellect", "Critical Strike", "Haste"},
                note = "BEST at max level with gear!"
            },
            Frost = {
                name = "Frost", role = "Ranged DPS", difficulty = "Easy",
                description = "Slow and freeze - BEST for leveling!",
                bestStats = {"Intellect", "Haste", "Mastery"}
            }
        },
        leveling_guide = {
            best_spec = "Frost",
            why = "Slows enemies, pet tanks, Ice Block safety!",
            tips = {
                "Summon Water Elemental to tank",
                "Frost Nova + Blink to escape",
                "Ice Block = full immunity",
                "Conjure food/water = free sustain!",
                "Polymorph for crowd control",
                "Portal/Teleport to cities!",
                "Time Warp = personal lust!"
            }
        }
    },
    
    Monk = {
        id = 7, name = "Monk", icon = 626002,
        armor = "Leather", resource = "Energy/Chi", roles = {"Tank", "Healer", "Melee DPS"},
        available_races = {
            Alliance = {"All except Worgen, Lightforged"},
            Horde = {"All except Goblin"}
        },
        specs = {
            Brewmaster = {
                name = "Brewmaster", role = "Tank", difficulty = "Hard",
                description = "Drunk tank - stagger damage!",
                bestStats = {"Agility", "Versatility", "Mastery"}
            },
            Mistweaver = {
                name = "Mistweaver", role = "Healer", difficulty = "Medium",
                description = "Fistweaving or channeling healer",
                bestStats = {"Intellect", "Versatility", "Critical Strike"}
            },
            Windwalker = {
                name = "Windwalker", role = "Melee DPS", difficulty = "Medium",
                description = "Mobile martial artist - kung fu master!",
                bestStats = {"Agility", "Versatility", "Mastery"}
            }
        },
        leveling_guide = {
            best_spec = "Windwalker",
            why = "Great AoE, self-healing, very mobile!",
            unique_benefits = {
                "50% XP bonus from Peak of Serenity quest!",
                "Roll + Flying Serpent Kick = insane mobility",
                "Touch of Death = execute at 35% HP",
                "Self-healing with Expel Harm"
            }
        }
    },
    
    Paladin = {
        id = 8, name = "Paladin", icon = 626003,
        armor = "Plate", resource = "Holy Power", roles = {"Tank", "Healer", "Melee DPS"},
        available_races = {
            Alliance = {"Human", "Dwarf", "Draenei", "Dark Iron Dwarf"},
            Horde = {"Blood Elf", "Tauren", "Zandalari Troll"}
        },
        specs = {
            Holy = {
                name = "Holy", role = "Healer", difficulty = "Easy",
                description = "Light-based healer with strong cooldowns",
                bestStats = {"Intellect", "Critical Strike", "Mastery"}
            },
            Protection = {
                name = "Protection", role = "Tank", difficulty = "Easy",
                description = "Holy shield tank with strong mitigation",
                bestStats = {"Stamina", "Haste", "Versatility"}
            },
            Retribution = {
                name = "Retribution", role = "Melee DPS", difficulty = "Easy",
                description = "Holy warrior with big two-hander!",
                bestStats = {"Strength", "Haste", "Critical Strike"},
                note = "Great for leveling! Self-healing + plate armor!"
            }
        },
        leveling_guide = {
            best_spec = "Retribution",
            why = "Tanky, self-healing, good damage!",
            tips = {
                "Flash of Light for emergency healing",
                "Divine Shield = full immunity 8 seconds",
                "Lay on Hands = full heal once per 10 mins",
                "Blessing of Protection on allies",
                "Can solo group quests easily!"
            }
        }
    },
    
    Priest = {
        id = 9, name = "Priest", icon = 626004,
        armor = "Cloth", resource = "Mana", roles = {"Healer", "Ranged DPS"},
        available_races = {
            Alliance = {"All except Worgen"},
            Horde = {"All except Orc"}
        },
        specs = {
            Discipline = {
                name = "Discipline", role = "Healer", difficulty = "Hard",
                description = "Heal through damage dealt - atonement!",
                bestStats = {"Intellect", "Haste", "Mastery"}
            },
            Holy = {
                name = "Holy", role = "Healer", difficulty = "Easy",
                description = "Traditional healer - Prayer of Healing spam",
                bestStats = {"Intellect", "Mastery", "Critical Strike"}
            },
            Shadow = {
                name = "Shadow", role = "Ranged DPS", difficulty = "Medium",
                description = "Void magic DPS with DoTs",
                bestStats = {"Intellect", "Haste", "Mastery"},
                note = "Best for leveling! Good AoE!"
            }
        },
        leveling_guide = {
            best_spec = "Shadow",
            why = "Multi-DoT, self-healing, strong!",
            tips = {
                "Vampiric Embrace for AoE healing",
                "Dispersion = damage reduction",
                "Mind Soothe to skip mobs",
                "Leap of Faith to save allies",
                "Shadow Word: Death execute"
            }
        }
    },
    
    Rogue = {
        id = 10, name = "Rogue", icon = 626005,
        armor = "Leather", resource = "Energy", roles = {"Melee DPS"},
        available_races = {
            Alliance = {"All except Draenei, Tauren"},
            Horde = {"All except Tauren"}
        },
        specs = {
            Assassination = {
                name = "Assassination", role = "Melee DPS", difficulty = "Easy",
                description = "Poison and bleeds - DoT master",
                bestStats = {"Agility", "Mastery", "Critical Strike"}
            },
            Outlaw = {
                name = "Outlaw", role = "Melee DPS", difficulty = "Easy",
                description = "Pirate rogue - Roll the Bones!",
                bestStats = {"Agility", "Versatility", "Critical Strike"},
                note = "BEST for leveling! Great AoE!"
            },
            Subtlety = {
                name = "Subtlety", role = "Melee DPS", difficulty = "Hard",
                description = "Shadow dance ninja - burst windows",
                bestStats = {"Agility", "Mastery", "Versatility"}
            }
        },
        leveling_guide = {
            best_spec = "Outlaw",
            why = "AoE, self-healing, consistent damage",
            tips = {
                "Stealth past mobs to quest objectives!",
                "Sap to CC one enemy",
                "Crimson Vial for healing",
                "Cloak of Shadows = magic immunity",
                "Vanish to drop combat",
                "Pick pockets for extra gold!",
                "Lockpicking for profession gold!"
            }
        }
    },
    
    Shaman = {
        id = 11, name = "Shaman", icon = 626006,
        armor = "Mail", resource = "Mana", roles = {"Healer", "Melee DPS", "Ranged DPS"},
        available_races = {
            Alliance = {"Draenei", "Dwarf", "Dark Iron Dwarf", "Kul Tiran"},
            Horde = {"Orc", "Tauren", "Troll", "Goblin", "Mag'har", "Highmountain", "Zandalari"}
        },
        specs = {
            Elemental = {
                name = "Elemental", role = "Ranged DPS", difficulty = "Easy",
                description = "Lightning and lava caster",
                bestStats = {"Intellect", "Critical Strike", "Versatility"}
            },
            Enhancement = {
                name = "Enhancement", role = "Melee DPS", difficulty = "Easy",
                description = "Dual-wield with elemental enchants!",
                bestStats = {"Agility", "Haste", "Mastery"},
                note = "BEST for leveling! Strong and fun!"
            },
            Restoration = {
                name = "Restoration", role = "Healer", difficulty = "Easy",
                description = "Totem-based chain healing",
                bestStats = {"Intellect", "Critical Strike", "Versatility"}
            }
        },
        leveling_guide = {
            best_spec = "Enhancement",
            why = "Strong melee, self-healing, ghost wolf speed!",
            tips = {
                "Ghost Wolf at level 10 (40% speed)",
                "Healing Surge for emergency healing",
                "Reincarnation = free brez every 30 mins!",
                "Totems for utility",
                "Bloodlust/Heroism for tough fights",
                "Water Walking across water!"
            }
        }
    },
    
    Warlock = {
        id = 12, name = "Warlock", icon = 626007,
        armor = "Cloth", resource = "Mana + Soul Shards", roles = {"Ranged DPS"},
        available_races = {
            Alliance = {"Human", "Dwarf", "Gnome", "Worgen", "Dark Iron"},
            Horde = {"Orc", "Undead", "Troll", "Blood Elf", "Goblin"}
        },
        specs = {
            Affliction = {
                name = "Affliction", role = "Ranged DPS", difficulty = "Easy",
                description = "Multi-DoT specialist - drain life!",
                bestStats = {"Intellect", "Mastery", "Haste"},
                note = "BEST for leveling! DoT and tank!"
            },
            Demonology = {
                name = "Demonology", role = "Ranged DPS", difficulty = "Medium",
                description = "Demon army summoner",
                bestStats = {"Intellect", "Haste", "Critical Strike"}
            },
            Destruction = {
                name = "Destruction", role = "Ranged DPS", difficulty = "Easy",
                description = "Fire and chaos - big Chaos Bolts!",
                bestStats = {"Intellect", "Haste", "Mastery"}
            }
        },
        leveling_guide = {
            best_spec = "Affliction",
            why = "DoT everything, pet tanks, drain tank heals you!",
            pet_guide = {
                leveling = "Voidwalker (tanks)",
                dungeons = "Imp (DPS boost)",
                pvp = "Felhunter (interrupts)"
            },
            tips = {
                "Healthstone = free heal",
                "Soulstone = free brez",
                "Fear for emergency",
                "Summon pets for free!",
                "Drain Life heals you!",
                "Corruption on everything!",
                "Summon portals for group!",
                "FREE MOUNT at level 20!"
            }
        }
    },
    
    Warrior = {
        id = 13, name = "Warrior", icon = 626008,
        armor = "Plate", resource = "Rage", roles = {"Tank", "Melee DPS"},
        available_races = {
            Alliance = {"All"},
            Horde = {"All"}
        },
        specs = {
            Arms = {
                name = "Arms", role = "Melee DPS", difficulty = "Easy",
                description = "Two-hander big hits - Mortal Strike!",
                bestStats = {"Strength", "Haste", "Mastery"},
                note = "BEST for leveling! Big crits!"
            },
            Fury = {
                name = "Fury", role = "Melee DPS", difficulty = "Easy",
                description = "Dual-wield two-handers! Enrage!",
                bestStats = {"Strength", "Haste", "Critical Strike"}
            },
            Protection = {
                name = "Protection", role = "Tank", difficulty = "Easy",
                description = "Shield tank - defensive stance",
                bestStats = {"Stamina", "Haste", "Versatility"}
            }
        },
        leveling_guide = {
            best_spec = "Arms",
            why = "Strong single target, victory rush healing!",
            tips = {
                "Victory Rush after each kill = free heal!",
                "Charge to close gaps",
                "Intimidating Shout for emergency",
                "Die by the Sword = damage reduction",
                "Execute spam below 20% HP!",
                "Ignore Pain for mitigation"
            }
        }
    }
}

-- Gear progression by level bracket
Classes.GearProgression = {
    ["1-20"] = {
        priority = "Weapons > Armor",
        note = "Get heirlooms if possible! Otherwise quest rewards are fine.",
        enchants = "None needed"
    },
    ["20-40"] = {
        priority = "Weapons > Primary Stat > Stamina",
        note = "Upgrade weapons frequently! Run dungeons for better gear.",
        enchants = "Basic enchants from AH or guild"
    },
    ["40-60"] = {
        priority = "Primary Stat > Secondary Stats start mattering",
        note = "Focus on quest chains with good rewards. Dungeons for weapons.",
        enchants = "Cheap enchants worth it now"
    },
    ["60-80"] = {
        priority = "iLvl > Primary Stat > Best Secondary Stats",
        note = "TBC/WotLK gear scales well. Dungeons + quests.",
        enchants = "Enchant everything!"
    },
    ["80-90"] = {
        priority = "Primary Stat > Secondary Stat priority per spec",
        note = "Cataclysm/Pandaria gear. Start caring about stats.",
        enchants = "Full enchants recommended"
    },
    ["90-Max"] = {
        priority = "iLvl > Optimized Secondary Stats",
        note = "Sim your character! Use Raidbots for stat weights.",
        enchants = "Mandatory for endgame",
        gems = "Socket everything with best gems",
        consumables = "Flasks, potions, food for raids/M+"
    }
}

return Classes
