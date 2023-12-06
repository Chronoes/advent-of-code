defmodule AdventOfCode.Y2023.Day06Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2023.Day06, as: Solver

  @sample_input """
  Time:      7  15   30
  Distance:  9  40  200
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 288
  end

  test "first stage" do
    assert Solver.solve_first() === 861_300
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 71503
  end

  test "second stage" do
    assert Solver.solve_second() === 28_101_347
  end
end
