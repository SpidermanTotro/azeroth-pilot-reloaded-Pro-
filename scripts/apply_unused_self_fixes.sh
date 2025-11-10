#!/usr/bin/env bash
set -euo pipefail

./scripts/run-luacheck.sh > /tmp/luacheck_out.txt || true
# strip ANSI color sequences to make parsing reliable
sed -r 's/\x1B\[[0-9;]*[mK]//g' /tmp/luacheck_out.txt > /tmp/luacheck_clean.txt

grep -E ":[0-9]+:[0-9]+: unused argument self$" /tmp/luacheck_clean.txt || true | while IFS= read -r line; do
  file=$(echo "$line" | sed -E 's/:([0-9]+):[0-9]+: unused argument self$//')
  lineno=$(echo "$line" | sed -E 's/^.*:([0-9]+):[0-9]+: unused argument self$/\1/')
  if [ ! -f "$file" ]; then
    echo "Skip missing $file"
    continue
  fi
  header_line=$(sed -n "${lineno}p" "$file" || true)
  # check header_line contains function and the token self
  if echo "$header_line" | grep -q "function" && echo "$header_line" | grep -q "\bself\b"; then
    echo "Patching $file:$lineno"
    # replace the first occurrence of 'self' on that line with '_'
    awk -v L="$lineno" 'NR==L { sub(/self/, "_") } { print }' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
  else
    echo "Skipping $file:$lineno (no single-line header with self)"
  fi
done

echo "Done applying single-line header fixes."
