defmodule AdventOfCode.Y2023.Day08Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2023.Day08, as: Solver

  @sample_input """
  RL

  AAA = (BBB, CCC)
  BBB = (DDD, EEE)
  CCC = (ZZZ, GGG)
  DDD = (DDD, DDD)
  EEE = (EEE, EEE)
  GGG = (GGG, GGG)
  ZZZ = (ZZZ, ZZZ)
  """

  @sample_input2 """
  LLR

  AAA = (BBB, BBB)
  BBB = (AAA, ZZZ)
  ZZZ = (ZZZ, ZZZ)
  """

  @sample_input3 """
  LR

  11A = (11B, XXX)
  11B = (XXX, 11Z)
  11Z = (11B, XXX)
  22A = (22B, XXX)
  22B = (22C, 22C)
  22C = (22Z, 22Z)
  22Z = (22B, 22B)
  XXX = (XXX, XXX
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 2
  end

  test "first stage 2nd sample" do
    assert Solver.solve_first(@sample_input2) === 6
  end

  test "first stage" do
    assert Solver.solve_first() === 15871
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input3) === 6
  end

  test "second stage" do
    assert Solver.solve_second() === 11_283_670_395_017
  end
end
