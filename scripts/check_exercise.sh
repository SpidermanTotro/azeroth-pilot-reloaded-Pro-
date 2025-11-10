#!/usr/bin/env bash
set -euo pipefail
if [ $# -lt 1 ]; then
  echo "Usage: $0 <exercise-folder>"
  exit 2
fi
folder="$1"
if [ ! -d "$folder" ]; then
  echo "Folder not found: $folder"
  exit 2
fi
toc_count=$(find "$folder" -maxdepth 1 -type f -name "*.toc" | wc -l)
xml_count=$(find "$folder" -maxdepth 1 -type f -name "*.xml" | wc -l)
lua_count=$(find "$folder" -maxdepth 1 -type f -name "*.lua" | wc -l)
if [ "$toc_count" -eq 0 ]; then
  echo "No .toc file found in $folder"
  exit 3
fi
if [ "$xml_count" -eq 0 ]; then
  echo "No .xml file found in $folder"
  exit 3
fi
if [ "$lua_count" -eq 0 ]; then
  echo "No .lua file found in $folder"
  exit 3
fi
echo "Found: $toc_count .toc, $xml_count .xml, $lua_count .lua in $folder"
echo "Running luacheck on .lua files..."
luacheck "$folder" --config .luacheckrc || true
echo "Done (luacheck may have reported warnings)." 
