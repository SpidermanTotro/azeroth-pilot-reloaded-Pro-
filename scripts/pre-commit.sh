#!/usr/bin/env bash
# Run luacheck on staged Lua files (intended to be used as a developer hook)
set -euo pipefail
staged=$(git diff --staged --name-only --diff-filter=ACM | grep -E '\.lua$' || true)
if [ -z "$staged" ]; then
  exit 0
fi
echo "Running luacheck on staged files..."
luacheck $staged --config .luacheckrc
status=$?
if [ $status -ne 0 ]; then
  echo "luacheck failed. Fix issues or unstage files."
  exit $status
fi
exit 0
