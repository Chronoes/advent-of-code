defmodule AdventOfCode.Y2020.Day09Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day09, as: Solver

  @sample_input """
  35
  20
  15
  25
  47
  40
  62
  55
  65
  95
  102
  117
  150
  182
  127
  219
  299
  277
  309
  576
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input, 5) === 127
  end

  test "first stage" do
    assert Solver.solve_first() === 23_278_925
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input, 5) === 62
  end

  test "second stage" do
    assert Solver.solve_second() === 4_011_064
  end
end
