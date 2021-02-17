type
  MultiSlice*[T] = object
    ## Sorted and minimized collection of slices of `T`.
    slices: seq[Slice[T]]

func toMultiSlice*[T](s: set[T]): MultiSlice[T] =
  ## Constructs a new `MultiSlice` from `s`.
  for i in s:
    if result.slices.len == 0 or i != result.slices[^1].b + 1:
      result.slices.add(i .. i)
    else:
      result.slices[^1].b = i

func toMultiSlice*[T](s: varargs[Slice[T]]): MultiSlice[T] =
  ## Constructs a new `MultiSlice` from `s`. `s` must be sorted
  ## and minimized.
  var max = low(T)
  for r in s:
    if r.a <= max + 1:
      raise newException(ValueError, "slice start " & $r.a &
        " not bigger enough than previous max " & $max)
    elif r.b < r.a:
      raise newException(ValueError, "misordered slice: " & $r)
    else:
      result.slices.add(r)
      max = r.b

func incl*[T](mr: var MultiSlice[T], val: T) =
  ## Includes element `val` in `mr`.
  for i in 0 ..< mr.slices.len:
    if val >= mr.slices[i].a:
      if val <= mr.slices[i].b:
        return
      elif val == mr.slices[i].b + 1:
        if i + 1 < mr.slices.len and val + 1 == mr.slices[i + 1].a:
          let newSlice = mr.slices[i].a .. mr.slices[i + 1].b
          mr.slices[i .. i + 1] = [newSlice]
        else:
          inc mr.slices[i].b
        return
    else:
      mr.slices.insert(val .. val, i)
      return
  mr.slices.add(val .. val)

func excl*[T](mr: var MultiSlice[T], val: T) =
  ## Excludes element `val` from `mr`.
  for i in 0 ..< mr.slices.len:
    if val >= mr.slices[i].a:
      if val <= mr.slices[i].b:
        let slice1 = mr.slices[i].a .. val - 1
        let slice2 = val + 1 .. mr.slices[i].b
        mr.slices.delete(i)
        if slice2.b >= slice2.a:
          mr.slices.insert(slice2, i)
        if slice1.b >= slice1.a:
          mr.slices.insert(slice1, i)
        return
    else:
      return

func len*[T](mr: MultiSlice[T]): T =
  ## Gives total number of elements in `mr`.
  for r in mr.slices:
    result += r.b - r.a + 1

iterator items*[T](mr: MultiSlice[T]): T =
  ## Iterates over every item in `mr`.
  for r in mr.slices:
    for val in r.items:
      yield val

func contains*[T](mr: MultiSlice[T], val: T): bool =
  ## Returns `true` if `val` is contained inside `mr`.
  for r in mr.slices:
    if val in r:
      return true
  return false

func `$`*[T](mr: MultiSlice[T]): string =
  ## Returns string of MultiSlice.
  result.add("MultiSlice{")
  for i, r in mr.slices:
    if i != 0:
      result.add(", ")
    if r.a == r.b:
      result.add($r.a)
    else:
      result.add($r)
  result.add('}')

func find*[T](mr: MultiSlice[T], val: T): T =
  ## Finds index of `val` in `mr`.
  for r in mr.slices:
    if val in r:
      result += val - r.a
      return
    else:
      result += r.b - r.a + 1

func findAs*[T](mr: MultiSlice[T], val: T, U: type): U =
  ## Finds index of `val` in `mr` as type `U`.
  for r in mr.slices:
    if val in r:
      result += U(val - r.a)
      return
    else:
      result += U(r.b - r.a + 1)

func `[]`*[T, U](mr: MultiSlice[T], i: U): T =
  ## Finds `T` in `mr` indexed by `i`.
  result = T(i)
  for r in mr.slices:
    if result + r.a <= r.b:
      return result + r.a
    else:
      result -= r.b - r.a + 1

func toIndexRange*[T](mr: static MultiSlice[T], val: T): auto =
  ## Finds `val` in `mr` and returns the index, but as the type of the range
  ## of indices (``range[0 .. mr.len - 1]``).
  mr.findAs(val, range[0 .. mr.len - 1])

when false:
  # too broken
  type MultiSliceIndex*[T, U; R: static MultiSlice[T]] = distinct U

  func toIndex*[T](mr: static MultiSlice[T], i: T): MultiSliceIndex[T, T, mr] =
    MultiSliceIndex[T, T, mr](mr.find(i))

  func toIndexAs*[T](mr: static MultiSlice[T], i: T, U: type): MultiSliceIndex[T, U, mr] =
    MultiSliceIndex[T, U, mr](mr.findAs(i, U))

  func unwrap*(ind: MultiSliceIndex): auto =
    ind.R[ind.val]
