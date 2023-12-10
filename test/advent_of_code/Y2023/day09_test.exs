defmodule AdventOfCode.Y2023.Day09Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2023.Day09, as: Solver

  @sample_input """
  0 3 6 9 12 15
  1 3 6 10 15 21
  10 13 16 21 30 45
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 114
  end

  test "first stage" do
    assert Solver.solve_first() === 2_101_499_000
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 2
  end

  test "second stage" do
    assert Solver.solve_second() === 1089
  end
end
