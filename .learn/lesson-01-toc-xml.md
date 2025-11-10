# Lesson 1 — TOC and XML basics

Goal: understand a `.toc` file and a minimal `.xml` UI file used by WoW addons.

What a `.toc` does
- Lists files the client should load (XML, Lua).
- Declares metadata: Interface, Title, Notes, SavedVariables.

Example (`templates/sample.toc`):
- `## Interface: 90005` — client interface number (keeps compatibility).
- `## SavedVariables: SampleAddonDB` — declares saved vars that persist across sessions.

XML basics
- Root element for frames: `<Ui xmlns="http://www.blizzard.com/wow/ui/">`.
- Use `<Script file="...">` to include a Lua file.
- Frames can declare size, anchors, layers and embedded `FontString` or `Button` nodes.

Exercise
1. Open `templates/SampleSample.xml` and `templates/sample.toc`.
2. Inspect how the `Script` tag points to `SampleSample.lua` and how the frame is built.
3. Try making a small change to the Frame's `<Text>` and run the `Run luacheck (full)` task to ensure nothing breaks in Lua.

Hints
- XML does not execute Lua; it references it. Behavior is implemented in the Lua file included by the `Script` tag.
