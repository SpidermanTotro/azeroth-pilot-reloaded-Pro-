# Review Guide — How to Safely Inspect and Approve Changes

This file explains how to review edits to this addon safely and reproducibly.

1) General rules
- Prefer small, focused commits. Each commit should do one thing (data fix, bug fix, style tidy).
- Functional changes must include a short test plan (how to reproduce & expected behavior).
- Style-only changes are okay but should be in a separate commit or PR.

2) Run the linter locally
- Install Lua 5.1 and luacheck (or use the repo dev container).
- Run:

```bash
luacheck . --config .luacheckrc
```

- Expect zero errors and a small number of warnings; investigate warnings that look like possible bugs (unused variables that should be used, shadowing, undefined globals).

3) Inspect diffs
- For data changes (e.g., `Data/Zones.lua`) ensure IDs and keys are authoritative. If an ID was changed, verify any consumers use the same ID.
- For UI changes, prefer renaming handler parameters instead of altering logic.

4) Test in-game
- Copy the addon into your `Interface/AddOns/` during development or use the path used by your WoW client.
- Reload UI with `/reload` after making changes.
- Watch the Lua Error frame or check the SavedVariables to ensure preferences persisted.

5) Reverting
- To revert a change: create a revert commit that reverts the offending file(s). Keep revert commits descriptive so the reason for rollback is clear.

6) Approving PRs
- Approve when: no runtime errors, linter run shows no errors, and tests reproduce correct behavior.
- If unsure, request small follow-up changes (e.g., rename variables, add guard checks) rather than an outright rejection.

7) Helpful commands
```bash
# show the last commit and changed files
git show --name-status HEAD

# create a new branch for fixes
git checkout -b fix/your-description

# stage and commit
git add -A
git commit -m "fix: brief description"

# run linter
luacheck . --config .luacheckrc
```

Keep PRs small and testable. If you want, I can prepare CI to run luacheck for all PRs automatically (recommended).