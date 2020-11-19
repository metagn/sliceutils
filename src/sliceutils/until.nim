## An alternative to system.`..<` which, instead of subtracting 1,
## treats the end of the slice as having a marginal difference
## from the given number.

type
  Until*[T] = object
    ## The type which represents a marginally smaller number than the given `T`. 
    val*: T
  
  UntilSlice*[T, U] = HSlice[T, Until[U]]

proc until*[T, U](a: T, b: U): UntilSlice[T, U] {.inline.} =
  ## Initializer of a slice with lower bound `a` and upper bound
  ## marginally below `b`.
  a .. Until[U](val: b)

iterator items*[T, U](s: UntilSlice[T, U]): auto =
  ## Iterates over ``items(s.a .. s.b.val)`` and yields all the values that are not equal to ``s.b.val``.
  for x in items(s.a .. s.b.val):
    if x != s.b.val:
      yield x

proc contains*[T, U, V](s: UntilSlice[T, U], x: V): bool =
  ## Checks that `x` is not equal to ``s.b.val``, then checks if ``s.a .. s.b.val`` contains `x`.
  x != s.b.val and contains(s.a .. s.b.val, x)

proc len*[T, U](s: UntilSlice[T, U]): int =
  ## Returns the value of ``len(s.a .. s.b.val)`` and subtracts 1 if ``s.b.val`` is in ``s.a .. s.b.val``. 
  let dummy = s.a .. s.b.val
  result = dummy.len
  if s.b.val in dummy:
    dec result
