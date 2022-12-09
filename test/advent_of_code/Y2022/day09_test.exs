defmodule AdventOfCode.Y2022.Day09Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2022.Day09, as: Solver

  @sample_input """
  R 4
  U 4
  L 3
  D 1
  R 4
  D 1
  L 5
  R 2
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 13
  end

  test "first stage" do
    assert Solver.solve_first() === 5710
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
