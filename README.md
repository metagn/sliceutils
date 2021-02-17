# sliceutils

Nimble package for extensions on Slice/HSlice. Features include:

* `tuples`: indexing tuples by backwards index and by slices of ordinals or backwards indexes
* `strides`: slice type with custom increments other than 1
* `until`: slice utility type that counts every element except the last one, made with floats in mind
* `intslices`: utility procedures for integer slices
  - subscript indexing for integer slices with ordinals, backwards indexes, or slices of ordinals or backwards indexes
  - `diff(HSlice[T, U: SomeInteger]): int`: the distance between the 2 bounds, has alias `abs`
* `general`: procedures for generic slices, examples being
  - `to(T, U) -> HSlice[T, U]`: alternate constructor for slices
  - `swap(HSlice[T, U]) -> HSlice[U, T]`: swaps the bounds of the slice
  - `sort(Slice[T]) -> Slice[T]`: gives the bounds ascending order
  - `span(HSlice[T, U]) -> int`: alias for `system.len` as `len` in this package means "number of results of an iteration"
  - `spans(HSlice[T, U], V) -> bool`: alias for `system.contains` as `contains` in this package means "is one of the given values of an iteration"
  - `@(HSlice[T, U]) -> seq`: makes seq from slice, iterations must match `len`
* `multislice`: sorted, minimalized sequence of `Slice[T]`

`import sliceutils` imports all of these modules.

Uses [nimbleutils](https://github.com/hlaaftana/nimbleutils) to build docs and run tests for multiple backends.

Warning: This package overuses the type system a bit and breaks very easily for versions below 1.4.0. Even on 1.4.0, you may come across Nim bugs.
