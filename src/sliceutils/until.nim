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

proc `<`*[T, U](a: T, b: Until[U]): bool {.inline.} =
  ## Alias for ``a < b.val``.
  a < b.val

proc `<=`*[T, U](a: T, b: Until[U]): bool {.inline.} =
  ## Resolves to ``a < b.val``, meaning the true value of `b` is excluded.
  a < b.val

iterator items*[T, U](s: UntilSlice[T, U]): auto =
  for x in items(s.a .. s.b.val):
    if x != s.b.val:
      yield x

proc len*[T, U](s: UntilSlice[T, U]): int =
  let dummy = s.a .. s.b.val
  result = dummy.len
  if s.b.val in dummy:
    dec result