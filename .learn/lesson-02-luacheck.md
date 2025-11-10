# Lesson 02 — Luacheck and style rules

This lesson shows how to run `luacheck` locally and how to interpret common warnings.

Quick run (after devcontainer setup):

```
export PATH="$HOME/.luarocks/bin:$PATH"
luacheck . --config .luacheckrc
```

Common warnings:
- `unused argument <name>` — often a WoW callback param like `self`, `elapsed`, `arg` that is unused; safe to rename to `_` if not used.
- `global` warnings — add common WoW API names to `.luacheckrc` globals.

Exercise:
1. Run luacheck and open the output.
2. Identify purely stylistic warnings and either fix them or add entries to `.luacheckrc`.
