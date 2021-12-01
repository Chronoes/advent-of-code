defmodule AdventOfCode.Y2021.Day01Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2021.Day01, as: Solver

  @sample_input """
  199
  200
  208
  210
  200
  207
  240
  269
  260
  263
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 7
  end

  test "first stage" do
    assert Solver.solve_first() === 1557
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 5
  end

  test "second stage" do
    assert Solver.solve_second() === 1608
  end
end
