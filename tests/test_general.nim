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
