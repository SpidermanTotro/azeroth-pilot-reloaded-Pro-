# Lesson 3 — Using luacheck and exercise workflow in Codespaces

Goal: run `luacheck` inside the devcontainer to validate Lua code and complete exercises.

Inside Codespaces / devcontainer
1. Reopen the repository in the container (Command Palette → Reopen in Container).
2. Open the Command Palette → Run Task → `Run luacheck (full)`.
3. Alternatively, run `./scripts/run-luacheck.sh` in the terminal.

Exercise flow
- Make a small change in `templates/SampleSample.lua` or create your own `exercise/` folder with `MyAddOn.toc`, `MyAddOn.xml`, `MyAddOn.lua`.
- Run the `scripts/check_exercise.sh` helper to validate basic structure and run `luacheck` on the Lua files:

  ./scripts/check_exercise.sh exercise/

The script will:
- verify a `.toc` exists in the folder
- check for at least one `.lua` and one `.xml` file
- run `luacheck` on all `.lua` files and report results

If `luacheck` reports warnings you can inspect and fix them; for WoW-specific globals add them to `.luacheckrc` if needed.
