when (compiles do: import nimbleutils/bridge):
  import nimbleutils/bridge
else:
  import unittest

import sliceutils/until

test "Int slice test":
  let sl = 1.until(5)
  var s: seq[int]
  for i in sl: s.add(i)
  check(s == @[1, 2, 3, 4])
  check(sl.len == 4)

import sliceutils/strides

test "Strides test":
  let sl = 1.by(3).until(10)
  var s: seq[int]
  for i in sl: s.add(i)
  check(s == @[1, 4, 7])
  check(7 in sl)
  check(10 notin sl)
  check(sl.len == 3)
  let sl2 = 1.by(3).until(11)
  s = @[]
  for i in sl2: s.add(i)
  check(s == @[1, 4, 7, 10])
  check(7 in sl2)
  check(10 in sl2)
  check(sl2.len == 4)
