proc to*[T, U](a: T, b: U): HSlice[T, U] {.inline.} =
  ## Alternate constructor for ``a .. b``.
  a .. b

proc span*[T, U: Ordinal](s: HSlice[T, U]): int {.inline.} =
  ## Alias for ``system.len(s)``.
  system.len(s)

proc spans*[T, U: Ordinal, V](s: HSlice[T, U], x: V): int {.inline.} =
  ## Alias for ``system.contains(s, x)``.
  system.contains(s, x)

proc swap*[T, U](s: HSlice[T, U]): HSlice[U, T] {.inline.} =
  ## Returns ``b .. a`` when given ``a .. b``.
  s.b .. s.a

proc sort*[T](s: Slice[T]): Slice[T] {.inline.} =
  ## Swaps boundaries of `s` if ``s.b < s.a``.
  if s.b < s.a:
    swap(s)
  else:
    s

iterator pairs*[T, U](s: HSlice[T, U]): (int, auto) =
  ## Returns ``(int, typeof(s.items, typeOfIter))``, where the first element of the tuple is the count of iterations before.
  ## Only needs an ``items`` iterator defined on `s`.
  var i = 0
  for x in s.items:
    yield (i, x)
    inc i