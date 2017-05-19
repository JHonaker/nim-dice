import random
import sequtils

type
  Die[T] = seq[T]

proc d(N: int): Die[int] =
  # Generator function for polyhedral dice with integer faces
  # Calling this returns a die with faces 1..N:
  #   d(3) = @[1, 2, 3]
  #   d(10) = @[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  #   etc.
  toSeq(1..N)

proc roll[T](die: Die[T]): T =
  # Rolls any die and chooses a face.
  random(die)

var d20 = d(20)
var dStr: Die[string] = @["a", "b", "c"]

if isMainModule:
  echo d20.roll
  echo d20.roll
  echo dStr.roll
