## This module contains utilities for slices of integers.
## These utilities include procs that allow treating slices of integers like
## collections of integers in generic routines.

proc diff*[T, U: SomeInteger](s: HSlice[T, U]): int {.inline.} =
  ## Returns the absolute value of ``s.b - s.a``.
  abs(int(s.b - s.a))

proc abs*[T, U: SomeInteger](s: HSlice[T, U]): int {.inline.} =
  ## Alias for `diff`.
  diff(s)

proc `[]`*[I: Ordinal; T, U: SomeInteger](s: HSlice[T, U], i: I): auto =
  ## Returns ``s.a + i``.
  s.a + i

proc `[]`*[T, U: SomeInteger](s: HSlice[T, U], i: BackwardsIndex): auto =
  ## Returns ``s.b + 1 - U(i)``.
  s.b + 1 - U(i)

proc `[]`*[I: Ordinal; T, U: SomeInteger](s: HSlice[T, U], i: HSlice[I, I]): auto =
  ## Returns ``s[i.a] .. s[i.b]``.
  s[i.a] .. s[i.b]

proc `[]`*[I: Ordinal; T, U: SomeInteger](s: HSlice[T, U], i: HSlice[I, BackwardsIndex]): auto =
  ## Returns ``s[i.a] .. s[i.b]``.
  s[i.a] .. s[i.b]

proc `[]`*[I: Ordinal; T, U: SomeInteger](s: HSlice[T, U], i: HSlice[BackwardsIndex, I]): auto =
  ## Returns ``s[i.a] .. s[i.b]``.
  s[i.a] .. s[i.b]

proc `[]`*[T, U: SomeInteger](s: HSlice[T, U], i: HSlice[BackwardsIndex, BackwardsIndex]): auto =
  ## Returns ``s[i.a] .. s[i.b]``.
  s[i.a] .. s[i.b]
