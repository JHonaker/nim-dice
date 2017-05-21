import random
import sequtils
import math
import algorithm

template until(condition, body: untyped) =
  while condition == false:
    body

type
  Die = seq[int]

proc d(N: int): Die =
  # Generator function for polyhedral dice with integer faces
  # Calling this returns a die with faces 1..N:
  #   d(3) = @[1, 2, 3]
  #   d(10) = @[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  #   etc.
  toSeq(1..N)

# Some common polyhedral dice used in RPGs
let
  d4* = d(4)
  d6* = d(6)
  d8* = d(8)
  d10* = d(10)
  d12* = d(12)
  d20* = d(20)
  d100* = d(100)
  dPercent* = d10.map do (x: int) -> int : (x - 1) * 10

proc roll(die: Die): int =
  random(die)

proc roll(die: Die, N: int): seq[int] =
  # Rolls any number of die and chooses a face.
  assert(N > 0)
  newSeq(result, N)
  for i in 0..<N:
    result[i] = die.roll

proc keepHighest(rolls: seq[int], N: int): seq[int] =
  if N < 0:
    result = @[]
  elif 0 <= N and N <= rolls.len:
    result = rolls.sorted(system.cmp[int])[(rolls.len - N)..<rolls.len]
  else:
    result = rolls

proc keepLowest(rolls: seq[int], N: int): seq[int] =
  if N < 0:
    result = @[]
  elif 0 <= N and N <= rolls.len:
    result = rolls.sorted(system.cmp[int])[0..<N]
  else:
    result = rolls

proc rollUntil(die: Die, predicate: proc (roll: int): bool): seq[int] =
  var rollnum = 0
  result = @[]
  result.add(die.roll)
  until(predicate(result[rollnum])):
    rollnum += 1
    result.add(die.roll)

proc explode(die: Die): seq[int] =
  rollUntil(die, proc(x: int): bool = x != die.max)

if isMainModule:
  echo dPercent.roll
  echo d20.roll(10).keepHighest(4)
  echo d20.roll(11).keepLowest(5)
  echo roll(d20, 3)
  echo rollUntil(d20, proc (x: int): bool = x == 20)
  echo rollUntil(d2, proc (x: int): bool = x == 2)
  echo d2.explode
