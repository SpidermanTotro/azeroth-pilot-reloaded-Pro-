#!/usr/bin/env python3
"""
Conservative autofix: rename unused 'self' function parameter to '_' when safe.

Rules:
- Run luacheck and parse warnings for 'unused argument self'.
- For each reported file/line, find the nearest enclosing 'function' header before that line.
- If the function body (between header and matching 'end') does not contain the token 'self', replace the parameter name 'self' with '_' in the header.

This is a heuristic tool; changes are style-only and should be reviewed.
"""

import re
import subprocess
from pathlib import Path
import sys


def run_luacheck():
    cmd = ["luacheck", ".", "--config", ".luacheckrc", "--formatter", "plain"]
    proc = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    out = proc.stdout
    return out


def parse_warnings(luacheck_out):
    # lines like: Core/Database.lua:83:12: unused argument self
    pattern = re.compile(r'^(.*?):(\d+):\d+: unused argument (\w+)$')
    issues = {}
    for line in luacheck_out.splitlines():
        m = pattern.match(line.strip())
        if m:
            path, lineno, arg = m.groups()
            lineno = int(lineno)
            if arg == 'self':
                issues.setdefault(path, set()).add(lineno)
    return issues


def find_function_header(lines, start_index):
    # search backwards from start_index (1-based) to find a line containing 'function'
    i = start_index - 1
    while i >= 0:
        if 'function' in lines[i]:
            return i
        i -= 1
    return None


def find_matching_end(lines, header_index):
    # naive matcher counting 'function' and 'end' tokens (doesn't parse strings/comments)
    depth = 0
    for i in range(header_index, len(lines)):
        # count 'function' occurrences
        depth += len(re.findall(r'\bfunction\b', lines[i]))
        depth -= len(re.findall(r'\bend\b', lines[i]))
        if depth <= 0:
            return i
    return None


def function_body_contains_self(lines, header_index, end_index):
    body = '\n'.join(lines[header_index+1:end_index])
    return 'self' in body


def replace_param_in_header(lines, header_index):
    # replace 'self' with '_' in the header parameter list only once
    header = lines[header_index]
    new_header = re.sub(r'\bself\b', '_', header, count=1)
    if new_header != header:
        lines[header_index] = new_header
        return True
    return False


def process_file(path, linenos):
    p = Path(path)
    if not p.exists():
        return 0
    text = p.read_text()
    lines = text.splitlines()
    changed = 0
    for lineno in sorted(linenos):
        header_idx = find_function_header(lines, lineno)
        if header_idx is None:
            continue
        end_idx = find_matching_end(lines, header_idx)
        if end_idx is None:
            continue
        if function_body_contains_self(lines, header_idx, end_idx):
            continue
        # safe to replace in header
        if replace_param_in_header(lines, header_idx):
            changed += 1
    if changed:
        p.write_text('\n'.join(lines) + '\n')
    return changed


def main():
    print('Running luacheck to collect unused-self warnings...')
    out = run_luacheck()
    issues = parse_warnings(out)
    total_changed = 0
    for path, linenos in issues.items():
        print(f'Processing {path}: {len(linenos)} unused-self warnings')
        changed = process_file(path, linenos)
        if changed:
            print(f'  Modified {changed} function headers in {path}')
        total_changed += changed
    print(f'Total headers modified: {total_changed}')
    if total_changed == 0:
        print('No safe changes detected.')


if __name__ == '__main__':
    main()
