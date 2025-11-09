# Contributing to Azeroth Pilot Reloaded Pro

First off, thank you for considering contributing to Azeroth Pilot Reloaded Pro! It's people like you that make this addon better than the paid alternatives.

## Our Mission

We're building the **best free, open-source leveling addon** for World of Warcraft. Our goal is to:
- Provide faster updates than commercial alternatives (Zygor, Dugi)
- Maintain a modern, clean codebase
- Stay completely FREE forever
- Build a strong community

## How Can I Contribute?

### 🐛 Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates.

**How to submit a good bug report:**
1. Use a clear, descriptive title
2. Describe the exact steps to reproduce
3. Provide specific examples
4. Describe the behavior you observed and what you expected
5. Include your WoW version, addon version, and any error messages

**Template:**
```markdown
**Describe the bug**
A clear description of the bug.

**To Reproduce**
Steps to reproduce:
1. Go to '...'
2. Click on '....'
3. See error

**Expected behavior**
What you expected to happen.

**Screenshots/Error Messages**
If applicable, add screenshots or Lua errors.

**Environment:**
- WoW Version: [e.g., 11.0.2]
- Addon Version: [e.g., 1.0.0]
- Other addons: [list if relevant]
```

### 💡 Suggesting Features

We love feature suggestions! Here's how to suggest them:

1. **Check existing issues** to see if it's already suggested
2. **Create a detailed proposal** explaining:
   - What problem does it solve?
   - How should it work?
   - Why is it better than alternatives?
3. **Consider the scope** - Will it benefit most users?

### 🗺️ Creating Routes

Routes are the heart of a leveling addon! Here's how to contribute:

**Route Requirements:**
- Optimized quest order
- Efficient travel paths
- Clear, helpful descriptions
- Tested from start to finish
- Both factions if applicable

**Route Structure:**
```lua
{
    id = "zone_minlevel_maxlevel",
    name = "Zone Name (Levels X-Y)",
    description = "Brief description",
    faction = "Alliance" or "Horde" or "Neutral",
    minLevel = X,
    maxLevel = Y,
    zone = mapID,
    author = "YourName",
    version = "1.0.0",
    lastUpdated = "YYYY-MM-DD",
    
    steps = {
        {
            title = "Clear title",
            description = "Detailed instructions",
            action = "accept|turnin|goto|kill|grind",
            questID = 12345, -- if applicable
            zone = "Subzone Name",
            waypoint = { x = 0.50, y = 0.50 } -- map coordinates (0-1)
        },
        -- more steps...
    }
}
```

### 💻 Code Contributions

**Setting Up:**
```bash
# Fork the repository
git clone https://github.com/YOUR-USERNAME/azeroth-pilot-reloaded-Pro-.git
cd azeroth-pilot-reloaded-Pro-

# Create a branch
git checkout -b feature/amazing-feature
```

**Code Style:**
- Use clear, descriptive variable names
- Comment complex logic
- Follow existing code patterns
- Keep functions focused and small
- Use Lua best practices

**Example:**
```lua
-- Good
function AzerothPilot:CalculateDistance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

-- Bad
function calc(a,b,c,d)
    return math.sqrt((c-a)^2+(d-b)^2)
end
```

**Testing:**
- Test in-game before submitting
- Test with different characters/levels
- Test both Alliance and Horde (if applicable)
- Check for Lua errors
- Verify performance (no lag spikes)

**Submitting:**
```bash
# Commit your changes
git add .
git commit -m "Add amazing feature"

# Push to your fork
git push origin feature/amazing-feature

# Create a Pull Request on GitHub
```

### 📝 Documentation

Documentation is crucial! You can help by:
- Improving README clarity
- Adding code comments
- Writing guides/tutorials
- Creating video walkthroughs
- Translating to other languages

### 🌍 Translation

We want APR Pro available in many languages!

**To translate:**
1. Copy `Locales/enUS.lua` to `Locales/yourLang.lua`
2. Translate all strings
3. Test in-game
4. Submit a Pull Request

**Supported Languages:**
- English (enUS) - Complete
- German (deDE) - Needed
- French (frFR) - Needed
- Spanish (esES/esMX) - Needed
- Russian (ruRU) - Needed
- Chinese (zhCN/zhTW) - Needed
- Korean (koKR) - Needed
- Portuguese (ptBR) - Needed

## Development Priorities

### High Priority
1. More leveling routes (all expansions)
2. Bug fixes and stability
3. Performance optimization
4. Pandaria Classic complete coverage

### Medium Priority
1. Custom route creator UI
2. Route import/export
3. Enhanced automation features
4. Better error messages

### Future
1. Profession guides
2. Achievement tracking
3. Dungeon routes
4. Advanced analytics

## Code Review Process

1. **Automated Checks**: Code must pass linting
2. **Manual Review**: A maintainer will review your code
3. **Testing**: Changes must be tested in-game
4. **Approval**: Once approved, it will be merged

## Community Guidelines

### Be Respectful
- Be kind and courteous
- Respect different opinions
- Constructive criticism only
- No harassment or toxicity

### Be Professional
- Keep discussions on-topic
- Use appropriate language
- Provide evidence for claims
- Acknowledge others' work

### Be Collaborative
- Help newcomers
- Share knowledge
- Give credit where due
- Work together on solutions

## Recognition

Contributors will be credited in:
- README.md Credits section
- In-game credits panel
- Release notes

## Questions?

- **General Questions**: Open a Discussion on GitHub
- **Bug Reports**: Open an Issue
- **Feature Requests**: Open an Issue with [FEATURE] tag
- **Security Issues**: Email security@example.com (if applicable)

## License

By contributing, you agree that your contributions will be licensed under GPL-3.0.

---

**Thank you for making Azeroth Pilot Reloaded Pro better than the paid alternatives!** 🚀
