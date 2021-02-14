## This module contains utilities for slices of integers.
## These utilities include procs that allow treating slices of integers like
## collections of integers in generic routines.

func diff*[T, U: SomeInteger](s: HSlice[T, U]): int {.inline.} =
  ## Returns the absolute value of ``s.b - s.a``.
  abs(int(s.b - s.a))

func abs*[T, U: SomeInteger](s: HSlice[T, U]): int {.inline.} =
  ## Alias for `diff`.
  diff(s)

func `[]`*[I: Ordinal; T, U: SomeInteger](s: HSlice[T, U], i: I): auto =
  ## Returns ``s.a + i``.
  s.a + i

func `[]`*[T, U: SomeInteger](s: HSlice[T, U], i: BackwardsIndex): auto =
  ## Returns ``s.b + 1 - U(i)``.
  s.b + 1 - U(i)

func `[]`*[I: Ordinal; T, U: SomeInteger](s: HSlice[T, U], i: HSlice[I, I]): auto =
  ## Returns ``s[i.a] .. s[i.b]``.
  s[i.a] .. s[i.b]

func `[]`*[I: Ordinal; T, U: SomeInteger](s: HSlice[T, U], i: HSlice[I, BackwardsIndex]): auto =
  ## Returns ``s[i.a] .. s[i.b]``.
  s[i.a] .. s[i.b]

func `[]`*[I: Ordinal; T, U: SomeInteger](s: HSlice[T, U], i: HSlice[BackwardsIndex, I]): auto =
  ## Returns ``s[i.a] .. s[i.b]``.
  s[i.a] .. s[i.b]

func `[]`*[T, U: SomeInteger](s: HSlice[T, U], i: HSlice[BackwardsIndex, BackwardsIndex]): auto =
  ## Returns ``s[i.a] .. s[i.b]``.
  s[i.a] .. s[i.b]
