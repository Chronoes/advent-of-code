defmodule AdventOfCode.Y2020.Day10Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day10, as: Solver

  @sample_input """
  16
  10
  15
  5
  1
  11
  7
  19
  6
  12
  4
  """

  @sample_input_2 """
  28
  33
  18
  42
  31
  14
  46
  20
  48
  47
  24
  23
  49
  45
  19
  38
  39
  11
  1
  32
  25
  35
  8
  17
  7
  9
  4
  2
  34
  10
  3
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 7 * 5
  end

  test "first stage second sample" do
    assert Solver.solve_first(@sample_input_2) === 22 * 10
  end

  test "first stage" do
    assert Solver.solve_first() === 2310
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 8
  end

  test "second stage second sample" do
    assert Solver.solve_second(@sample_input_2) === 19208
  end

  test "second stage" do
    assert Solver.solve_second() === 64_793_042_714_624
  end
end
