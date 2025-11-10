# Devcontainer for Azeroth Pilot — Lua + luacheck

This devcontainer prepares a reproducible Codespaces / devcontainer environment for developing and linting this World of Warcraft addon.

What it installs
- Lua 5.1
- luarocks
- luacheck (via luarocks)

How to use
1. Open this repository in Codespaces or VS Code and choose "Reopen in Container".
2. After the container builds, run the task "Run luacheck (full)" from the Command Palette / Tasks to lint the repo.
3. Optionally run `./scripts/run-luacheck.sh` in the terminal.

Developer hooks
- `scripts/pre-commit.sh` is provided; to enable it as a Git hook:

  cp scripts/pre-commit.sh .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit

This is intentionally opt-in.
