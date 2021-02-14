when (compiles do: import nimbleutils/bridge):
  import nimbleutils/bridge
else:
  import unittest

import sliceutils/strides

test "Length":
  check:
    len(1.by(3) .. 10) == 4
    len(1.by(3) .. 11) == 4
    len(1.by(3) .. 12) == 4
    len(1.0.by(0.5) .. 3.0) == 5

from math import `mod`
test "Contains":
  let si = 1.by(3) .. 11
  check(10 in si)
  check(9 notin si)

  let sf = 1.0.by(0.5)..3.0
  check(2.5 in sf)
  check(2.3 notin sf)

test "Iteration":
  var s1: seq[int]
  for i in 1.by(3)..11:
    s1.add(i)
  check(s1 == @[1, 4, 7, 10])

  var s2: seq[float]
  for i in 1.0.by(0.5)..3.0:
    s2.add(i)
  check(s2 == @[1.0, 1.5, 2.0, 2.5, 3.0])

test "Indexing":
  let sl = 1.by(3) .. 11
  check:
    sl[0] == 1
    sl[1] == 4
    sl[^1] == 10
    sl[^2] == 7
    sl[1..2] == 4.by(3)..7
    sl[1..^2] == 4.by(3)..7
    sl[^2..^1] == 7.by(3)..10
