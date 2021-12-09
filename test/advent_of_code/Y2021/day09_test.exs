defmodule AdventOfCode.Y2021.Day09Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2021.Day09, as: Solver

  @sample_input """
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 15
  end

  test "first stage" do
    assert Solver.solve_first() === 541
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 1134
  end

  @tag :skip
  test "second stage" do
    assert Solver.solve_second() === true
  end
end
