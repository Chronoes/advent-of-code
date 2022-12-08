defmodule AdventOfCode.Y2022.Day08Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2022.Day08, as: Solver

  @sample_input """
  30373
  25512
  65332
  33549
  35390
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 21
  end

  test "first stage" do
    assert Solver.solve_first() === 1681
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 8
  end

  test "second stage" do
    assert Solver.solve_second() === 201_684
  end
end
