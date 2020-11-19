import unittest

import sliceutils/intslices

test "Length, high, indexing for int":
  let s = 4..10
  check:
    s.diff == 6
    s[3] == 7
    s[^2] == 9
    s[2..5] == 6..9
    s[2..^2] == 6..9
    s[^4..5] == 7..9
    s[^4..^2] == 7..9

test "Length, high, indexing for uint16":
  let s = 4u16..10u16
  check:
    s.diff == 6
    s[3u16] == 7
    s[^2] == 9
    s[2u16..5u16] == 6u16..9u16
    s[2u16..^2] == 6u16..9u16
    s[^4..5u16] == 7u16..9u16
    s[^4..^2] == 7u16..9u16
