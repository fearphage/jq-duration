# duration.jq

This utility calculates the duration of time in seconds.


This is a utility function requires [jq](https://stedolan.github.io/jq/), the command-line JSON
processor.

## Usage

Duration accepts three paramaters: `duration(length; separator; error)`

1. length - This is the maximum number of segments to display. `1y 1d 1h 1m 1s` limited to
   length 2 would return `1y 1d`. The default value is zero (`0`) which means display all segments.
1. separator - The character used to separate the segments. The default value is a space
    (` `).
1.  error value - What is displayed when the input is invalid (read: not a number). The default
    value is a dash (`-`).

## Examples

```shell
$ echo 12345 | jq 'include "duration"; duration';
"3h 25m 45s"

$ echo '[3601, 12345, 31539601]' | jq 'import "duration" as dur; map(dur::duration(2))
[
  "1h 1s",
  "3h 25m",
  "36d 13h"
]

$ echo '[null, "{}", "[]"]' | jq 'import "duration" as dur; map(dur::duration)
[
  "-",
  "-",
  "-"
]

$ echo '[34000555, "{}", 12345, null, 3159601]' | \
    jq 'import "./duration" as main; map(main::duration(3; ""; "invalid")

[
  "1y28d12h",
  "invalid",
  "3h25m45s",
  "invalid",
  "36d13h40m"
]
```
