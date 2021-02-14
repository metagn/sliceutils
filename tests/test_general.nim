when (compiles do: import nimbleutils/bridge):
  import nimbleutils/bridge
else:
  import unittest

import sliceutils/general

test "Pairs iterator":
  var s: seq[(int, int)]
  for i, n in pairs 1..5:
    s.add((i, n))
  check(s == @{0: 1, 1: 2, 2: 3, 3: 4, 4: 5})

import sliceutils/strides

test "Pairs with strides":
  var s: seq[(int, int)]
  for i, n in pairs 1.by(2)..9:
    s.add((i, n))
  check(s == @{0: 1, 1: 3, 2: 5, 3: 7, 4: 9})

import sliceutils/until
from math import `mod`

test "@ operator":
  check @(1..5) == @[1, 2, 3, 4, 5]
  check @(1.by(2).to(9)) == @[1, 3, 5, 7, 9]
  check @(1.0.by(0.5).until(3.0)) == @[1.0, 1.5, 2.0, 2.5]
