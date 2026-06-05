#!/usr/bin/env bash
#
# run_tests.sh, verify clop against fixtures with known, hand-counted results.
#
# For every tests/fixtures/<name>.help there is a tests/fixtures/<name>.expected
# holding the single CSV line clop should produce in --csv --no-header mode:
#
#     name,version,total,with,without,short,long
#
# (The version field is empty for file-based fixtures, since there is no
# program to query for a version.)
#
# The script prints PASS/FAIL per fixture and exits non-zero if any test fails.

set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
clop="$here/../clop"
fixtures="$here/fixtures"

pass=0
fail=0

printf 'Running clop fixture tests\n'
printf '%s\n' "--------------------------"

for help_file in "$fixtures"/*.help; do
	name="$(basename "$help_file" .help)"
	expected_file="$fixtures/$name.expected"

	if [[ ! -f $expected_file ]]; then
		printf 'SKIP  %-10s (no .expected file)\n' "$name"
		continue
	fi

	expected="$(cat "$expected_file")"
	actual="$("$clop" --csv --no-header -f "$help_file")"

	if [[ $actual == "$expected" ]]; then
		printf 'PASS  %-10s %s\n' "$name" "$actual"
		pass=$(( pass + 1 ))
	else
		printf 'FAIL  %-10s\n        expected: %s\n        actual:   %s\n' \
			"$name" "$expected" "$actual"
		fail=$(( fail + 1 ))
	fi
done

# A best-effort smoke test against a real program, when one is available.
if command -v ls >/dev/null 2>&1; then
	if "$clop" ls >/dev/null 2>&1; then
		printf 'PASS  %-10s (smoke test: ran without error)\n' "ls"
		pass=$(( pass + 1 ))
	else
		printf 'FAIL  %-10s (smoke test: clop exited non-zero)\n' "ls"
		fail=$(( fail + 1 ))
	fi
fi

printf '%s\n' "--------------------------"
printf '%d passed, %d failed\n' "$pass" "$fail"

[[ $fail -eq 0 ]]
