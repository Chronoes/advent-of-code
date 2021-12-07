defmodule AdventOfCode.Y2021.Day05Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2021.Day05, as: Solver

  @sample_input """
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 5
  end

  test "first stage" do
    assert Solver.solve_first() === 6005
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 12
  end

  test "second stage" do
    assert Solver.solve_second() === 23864
  end
end
