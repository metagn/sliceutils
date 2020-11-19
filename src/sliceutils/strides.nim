## Implementation of slices with non-1 increments.

type
  Stride*[T, U: SomeNumber] = object
    ## The low bound of a slice that has an additional `step`
    ## property that describes the increment of the slice.
    base*: T
    step*: U
  
  StridedSlice*[T, U, V: SomeNumber] = HSlice[Stride[T, U], V]
    ## An alias for a slice with the low bound being a stride.

proc by*[T, U: SomeNumber](base: T, step: U): Stride[T, U] {.inline.} =
  ## Initializes a stride with base `base` and step `step`.
  Stride[T, U](base: base, step: step)

proc by*[T, U, V: SomeNumber](s: HSlice[T, U], step: U): StridedSlice[T, U, V] {.inline.} =
  ## Initializes a stride with over the slice `s` with step `step`.
  s.a.by(step) .. s.b

proc contains*[T, U, V, W: SomeNumber](s: StridedSlice[T, U, V], x: W): bool =
  ## Returns true if `x` is a value given by iterating over `s`.
  ## Requires `W - T -> X` and `X mod U -> Y: SomeNumber`,
  ## meaning you need math.mod for floats.
  x >= s.a.base and x <= s.b and (x - s.a.base) mod s.a.step == 0

proc len*[T, U, V: SomeNumber](s: StridedSlice[T, U, V]): int {.inline.} =
  ## Guess of number of iterations over ``s``.
  when compiles((s.b - s.a.base + s.a.step) div s.a.step):
    int((s.b - s.a.base + s.a.step) div s.a.step)
  else:
    int((s.b - s.a.base + s.a.step) / s.a.step)

iterator items*[T, U, V: SomeNumber](s: StridedSlice[T, U, V]): auto =
  ## Iterates over ``s``.
  var x = s.a.base
  while x <= s.b:
    yield x
    x += s.a.step

proc `[]`*[I: Ordinal, T, U, V: SomeNumber](s: StridedSlice[T, U, V], i: I): auto {.inline.} =
  ## Returns the number given at the `i` th iteration over `s`.
  s.a.base + s.a.step * U(i)

proc `[]`*[T, U, V: SomeNumber](s: StridedSlice[T, U, V], i: BackwardsIndex): auto {.inline.} =
  ## Returns the number given at the `i` th iteration starting from the end over `s`.
  s[s.len - i.int]

proc `[]`*[I: Ordinal; T, U, V: SomeNumber](s: StridedSlice[T, U, V], i: HSlice[I, I]): auto {.inline.} =
  ## Returns ``s[i.a] .. s[i.b]``.
  s[i.a].by(s.a.step) .. s[i.b]

proc `[]`*[I: Ordinal; T, U, V: SomeNumber](s: StridedSlice[T, U, V], i: HSlice[I, BackwardsIndex]): auto {.inline.} =
  ## Returns ``s[i.a] .. s[i.b]``.
  s[i.a].by(s.a.step) .. s[i.b]

proc `[]`*[I: Ordinal; T, U, V: SomeNumber](s: StridedSlice[T, U, V], i: HSlice[BackwardsIndex, I]): auto {.inline.} =
  ## Returns ``s[i.a] .. s[i.b]``.
  s[i.a].by(s.a.step) .. s[i.b]

proc `[]`*[T, U, V: SomeNumber](s: StridedSlice[T, U, V], i: HSlice[BackwardsIndex, BackwardsIndex]): auto {.inline.} =
  ## Returns ``s[i.a] .. s[i.b]``.
  s[i.a].by(s.a.step) .. s[i.b]
