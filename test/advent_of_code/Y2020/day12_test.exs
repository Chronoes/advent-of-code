defmodule AdventOfCode.Y2020.Day12Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day12, as: Solver

  @sample_input """
  F10
  N3
  F7
  R90
  F11
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 25
  end

  test "first stage" do
    assert Solver.solve_first() === 636
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 286
  end

  test "second stage" do
    assert Solver.solve_second() === 26841
  end
end
