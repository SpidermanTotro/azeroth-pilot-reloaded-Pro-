# QuestMaster Pro — Clean Start

This branch (`clean/start-over`) contains a fresh, minimal scaffold for QuestMaster Pro. The original project files were removed on this branch to give a clean workspace; history remains in git and other branches.

Included in this scaffold:
- `QuestMasterPro.toc` — addon metadata
- `Main.lua` — minimal loader and slash command
- `Core/Init.lua`, `Core/Utils.lua` — core initializers and helpers
- `UI/MainFrame.lua` — small toggleable UI for quick testing
- `.devcontainer/` — devcontainer to run Lua and luacheck (added)
- `.learn/` — short lessons to teach Lua addon basics and luacheck (added)

What I can do next (pick one):
- Add CI (luacheck) configured for this scaffold
- Add a polished `README.md` and contributor guide
- Re-import selected data/guides into `Data/clean/` from the repo history

If you want me to continue, say which next step to run and I'll implement it on `clean/start-over` and push a PR.
