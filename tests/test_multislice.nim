when (compiles do: import nimbleutils/bridge):
  import nimbleutils/bridge
else:
  import unittest

import sliceutils/multislice

test "Set test":
  let ourSet: set[uint8] = {uint8 1, 4..7, 15..19, 21, 23..28}
  let converted = toMultiSlice(ourSet)
  var mr1: MultiSlice[uint8]
  for u in ourSet:
    mr1.incl(u)
  check converted == mr1
  check mr1.len.int == ourSet.card

  var i = 0
  for x in mr1:
    let index = mr1.find(x)
    check index == uint8(i)
    check mr1[index] == x
    inc i
  
  for u in ourSet:
    mr1.excl(u)
  
  check mr1.len.int == 0

test "Index":
  const mr = toMultiSlice(1_000_000 .. 1_000_050, 3_000_000 .. 3_000_020)
  for val in [1_000_027, 3_000_015]:
    check mr[mr.findAs(val, uint8)] == val
