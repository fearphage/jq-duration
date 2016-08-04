#!/usr/bin/env bash

set -e

. ./assert.sh

duration_default="jq -L .. -r 'include \"duration\"; duration'"
duration="jq -L .. -r 'include \"duration\"; duration"

assert "$duration_default" '-' 'null'
assert "$duration_default" '-' '{}'
assert "$duration_default" '-' '[]'
assert_end bad input

assert "$duration(1; \" \"; \"why?\")'" 'why?' 'null'
assert "$duration(0; \" \"; \"???\")'" '???' 'null'
assert_end default

assert "$duration_default" '0s' 0
assert "$duration_default" '59s' 59
assert "$duration_default" '1m' 60
assert "$duration_default" '1h' $((60 * 60))
assert "$duration_default" '1d' $((60 * 60 * 24))
assert "$duration_default" '1y' $((60 * 60 * 24 * 365))
assert_end math

assert "$duration_default" '1y 1h 1s' 31539601
assert "$duration_default" '1y 1s' 31536001
assert_end sparse

assert "$duration(3)'" '3h 25m 45s' 12345
assert "$duration(2)'" '3h 25m' 12345
assert "$duration(1)'" '3h' 12345
assert "$duration(2)'" '31y 116d' 987654321
assert "$duration(4)'" '2y 170d 4h 56m' 77777777
assert "$duration_default" '3h 25m 45s' 12345
assert "$duration_default" '3h 25m 45s' 12345
assert_end length

assert "$duration(0; \".\")'" '3h.25m.45s' 12345
assert "$duration(0; \"\")'" '3h25m45s' 12345
assert "$duration(1; \"\")'" '3h' 12345
assert "$duration(2; \"\n\")'" '3h\n25m' 12345
assert_end seperator
