# Learn Codespaces: Lua, XML and TOC for WoW addons

This short guide walks you through using the provided devcontainer and lessons to practice writing safe Lua, XML UI, and TOC files for World of Warcraft addons.

Quick start
1. Reopen the repository in the devcontainer (Command Palette → Reopen in Container).
2. Run the VS Code Task: `Run luacheck (full)` to ensure `luacheck` is available.
3. Open `.learn/lesson-01-toc-xml.md` and follow the exercises.

What you'll learn
- How `.toc` files control what the client loads.
- How XML defines UI frames and how Lua files are included via `<Script file="...">`.
- The safe Lua patterns: register events, use `PLAYER_LOGIN`, and persist data via SavedVariables.
- How to run `luacheck` and interpret warnings, and where to adjust `.luacheckrc` for WoW globals.

Exercises location
- `templates/` contains a minimal sample addon you can modify.
- Create an `exercise/` folder to try your own sample and run `./scripts/check_exercise.sh exercise/` to validate.

If you'd like, I can:
- Move these learning files to a review branch and open a draft PR.
- Remove the learning docs from the repository if you prefer them not to be stored here.
