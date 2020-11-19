## This module allows for the indexing of tuples using slices.

import macros, typetraits

when not declared(tupleLen):
  template tupleLen(T): untyped = arity(T)

template `[]`*[T: tuple](t: T, i: static BackwardsIndex): auto =
  ## A redefinition of tuple indexing with the index argument made to be static.
  system.`[]`(t, tupleLen(T).int - i.int)
template `[]`*[T: tuple](t: T, i: static int): auto =
  ## A redefinition of tuple indexing with the index argument made to be static.
  system.`[]`(t, i)

proc `[]`*[T: tuple](t: T, s: static[Slice[int]]): auto {.inline.} =
  ## Slice indexing of tuples from an integer index to an integer index.
  macro generate(t: untyped, s: static[Slice[int]]): untyped =
    result = newTree(nnkTupleConstr)
    for i in s.a..s.b:
      result.add(newTree(nnkBracketExpr, t, newLit i))
  generate(t, s)

proc `[]`*[T: tuple](t: T, s: static[HSlice[BackwardsIndex, BackwardsIndex]]): auto {.inline.} =
  ## Slice indexing of tuples from a backwards index to a backwards index.
  macro generate(t: untyped, s: static[HSlice[BackwardsIndex, BackwardsIndex]]): untyped =
    result = newTree(nnkTupleConstr)
    for i in tupleLen(T).int - s.a.int..tupleLen(T).int - s.b.int:
      result.add(newTree(nnkBracketExpr, t, newLit i))
  generate(t, s)

proc `[]`*[T: tuple](t: T, s: static[HSlice[int, BackwardsIndex]]): auto {.inline.} =
  ## Slice indexing of tuples from an integer index to a backwards index.
  macro generate(t: untyped, s: static[HSlice[int, BackwardsIndex]]): untyped =
    result = newTree(nnkTupleConstr)
    for i in s.a..tupleLen(T).int - s.b.int:
      result.add(newTree(nnkBracketExpr, t, newLit i))
  generate(t, s)

proc `[]`*[T: tuple](t: T, s: static[HSlice[BackwardsIndex, int]]): auto {.inline.} =
  ## Slice indexing of tuples from a backwards index to an integer index.
  macro generate(t: untyped, s: static[HSlice[BackwardsIndex, int]]): untyped =
    result = newTree(nnkTupleConstr)
    for i in tupleLen(T).int - s.a.int..s.b.int:
      result.add(newTree(nnkBracketExpr, t, newLit i))
  generate(t, s)
