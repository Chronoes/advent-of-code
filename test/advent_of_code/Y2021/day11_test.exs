defmodule AdventOfCode.Y2021.Day11Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2021.Day11, as: Solver

  @sample_input """
  5483143223
  2745854711
  5264556173
  6141336146
  6357385478
  4167524645
  2176841721
  6882881134
  4846848554
  5283751526
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 1656
  end

  # Remove :skip tag when answer found
  @tag :skip
  test "first stage" do
    assert Solver.solve_first() === true
  end

  @tag :skip
  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === true
  end

  @tag :skip
  test "second stage" do
    assert Solver.solve_second() === true
  end
end
