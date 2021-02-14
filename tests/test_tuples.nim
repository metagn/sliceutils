when (compiles do: import nimbleutils/bridge):
  import nimbleutils/bridge
else:
  import unittest

import sliceutils/tuples

test "Indexing":
  let a = (1, 2, 3, "hi", 4, 5)
  check:
    a[^3] == "hi"
    a[2..4] == (3, "hi", 4)
    a[3..^1] == ("hi", 4, 5)
    a[^4..3] == (3, "hi")
    a[^4..^2] == (3, "hi", 4)
